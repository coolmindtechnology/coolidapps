import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/pages/curhat/normal_user/rating_curhat.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';

class ChatCurhatPage extends StatefulWidget {
  final bool status;

  const ChatCurhatPage({super.key, required this.status});

  @override
  _ChatCurhatPageState createState() => _ChatCurhatPageState();
}

class _ChatCurhatPageState extends State<ChatCurhatPage> {
  List<Map<String, String>> messages = [
    {
      "text":
          "Sejelek apapun masa lalumu, itu telah berlalu. Sekarang, fokus untuk kebahagiaan dirimu di masa depan.",
      "sender": "bot"
    },
    {"text": "Bagaimana bisa itu ya?", "sender": "user"},
    {
      "text":
          "Ketika kamu merasa kehilangan harapan, ingat bahwa Tuhan telah menciptakan rencana terindah untuk hidup kita.",
      "sender": "bot"
    },
    {"text": "Makasih ya", "sender": "user"},
  ];

  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _remainingSeconds = 6; // Waktu lebih pendek untuk testing
  bool _isRecording = false;
  FlutterSoundRecorder? _audioRecorder;

  @override
  void initState() {
    super.initState();
    if (widget.status) {
      _startTimer();
      _audioRecorder = FlutterSoundRecorder();
      _initializeRecorder();
    }
  }

  Future<void> _initializeRecorder() async {
    if (await Permission.microphone.request().isGranted) {
      await _audioRecorder!.openRecorder();
    } else {
      throw RecordingPermissionException("Microphone permission not granted");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    if (_audioRecorder != null) {
      _audioRecorder!.closeRecorder();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _remainingSeconds > 0) {
      setState(() {
        messages.add({"text": _controller.text, "sender": "user"});
        _controller.clear();
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> _pickFile() async {
    await FilePicker.platform.pickFiles(type: FileType.image);
  }

  Future<void> _startRecording() async {
    if (await Permission.microphone.request().isGranted) {
      setState(() {
        _isRecording = true;
      });
      await _audioRecorder!.startRecorder(toFile: 'audio_record.aac');
    }
  }

  Future<void> _stopRecording() async {
    if (_audioRecorder!.isRecording) {
      String? path = await _audioRecorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      if (path != null) {
        print("File rekaman tersimpan di: $path");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).PARENTING,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: _remainingSeconds > 0 ? Colors.blue : Colors.red,
                    width: 5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    _remainingSeconds > 0
                        ? _formatTime(_remainingSeconds)
                        : S.of(context).Archives,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: _remainingSeconds > 0 ? Colors.blue : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/konsultasi/profile1.png',
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Viviana Entira',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Creative',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: BlueColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).PARENTING,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '09.00 - 09.30',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (_remainingSeconds == 0)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                color: Colors.grey[50],
                padding: EdgeInsets.all(10),
                child: Text(
                  S.of(context).Session_Closed_Message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          SizedBox(
            height: 100,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isUser = messages[index]['sender'] == 'user';
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(messages[index]['text']!),
                    ),
                  );
                },
              ),
            ),
          ),
          _remainingSeconds > 0
              ? Container(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 20, bottom: 20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: BlueColor,
                          ),
                          onPressed: _pickImage,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: BlueColor,
                          ),
                          onPressed: _pickFile,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              controller: _controller,
                              onChanged: (text) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: S.of(context).Write_Here,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: BlueColor,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _controller.text.isEmpty ? Icons.mic : Icons.send,
                            color: BlueColor,
                          ),
                          onPressed: _controller.text.isEmpty
                              ? (_isRecording
                                  ? _stopRecording
                                  : _startRecording)
                              : _sendMessage,
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: TextButton(
                    onPressed: () {
                      Nav.to(RatingCurhat());
                    },
                    child: Text(S.of(context).Give_Rating),
                  ),
                ),
        ],
      ),
    );
  }
}
