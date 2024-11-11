import 'dart:io';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class CameraExample extends StatefulWidget {
  Function(XFile videoRes)? onUpdate;
  final Function? onRecord;
  CameraExample({super.key, this.onRecord, this.onUpdate});

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late VideoPlayerController _videoPlayerController;
  late List<CameraDescription> _cameras;
  bool isRecording = false;
  bool isPlaying = false;
  XFile? videoFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras.first,
      ResolutionPreset.medium,
      enableAudio: true,
    );
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (!_cameraController.value.isInitialized) {
      return;
    }
    setState(() {
      isRecording = true;
    });
    try {
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String videoDirectory = '${appDirectory.path}/Videos';
      await Directory(videoDirectory).create(recursive: true);
      final String currentTime =
          DateTime.now().millisecondsSinceEpoch.toString();
      final String filePath = '$videoDirectory/VIDEO_$currentTime.mp4';

      await _cameraController.startVideoRecording();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isInitialized ||
        !_cameraController.value.isRecordingVideo) {
      return;
    }
    try {
      XFile video = await _cameraController.stopVideoRecording();
      setState(() {
        isRecording = false;
        videoFile = video;
      });
      await _initializeVideoPlayer();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initializeVideoPlayer() async {
    if (videoFile != null) {
      _videoPlayerController =
          VideoPlayerController.file(File(videoFile!.path));
      await _videoPlayerController.initialize();
      setState(() {
        // Nav.back();
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record Video"),
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(children: [
              if (videoFile != null) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 50,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isPlaying) {
                            _videoPlayerController.pause();
                          } else {
                            _videoPlayerController.play();
                          }
                          isPlaying = !isPlaying;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.check, color: primaryColor, size: 50),
                      onPressed: () {
                        widget.onUpdate!(videoFile!);
                        Nav.back();
                      },
                    ),
                  ],
                ),
              ] else ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: AspectRatio(
                    aspectRatio: _cameraController.value.aspectRatio,
                    child: CameraPreview(_cameraController),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(isRecording ? Icons.stop : Icons.circle,
                            color: Colors.red, size: 80),
                        onPressed:
                            isRecording ? _stopRecording : _startRecording,
                      ),
                    ]),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       ElevatedButton(
                //         onPressed:
                //             isRecording ? _stopRecording : _startRecording,
                //         child: Text(
                //             isRecording ? 'Stop Recording' : 'Start Recording'),
                //       ),
                //       ElevatedButton(
                //         onPressed: () {
                //           widget.onUpdate!(videoFile!);
                //           Nav.back();
                //         },
                //         child: const Text('OK'),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
