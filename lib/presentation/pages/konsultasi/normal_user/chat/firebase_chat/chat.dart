import 'dart:async';
import 'dart:io';

import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
    this.user,
    required this.idUser,
  });

  final types.Room room;
  final dynamic user;
  final String idUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;
  Timer? timerr;
  int _remainingSeconds = 1; // Waktu lebih pendek untuk testing
  final bool isRecordingg = false;
  bool isVisibleChat = false;

  void startTimerr() {
    timerr = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _postEndRoom();
        debugPrint('pos endddddd');
      }
    });
  }

  bool _isPosting = false;
  @override
  void initState() {
    cekSession();
    startTimerr();
    fetchDurationFromApi(widget.idUser);
    _startCountdown();
    super.initState();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    if (ceklanguage == null) {
      Prefs().setLocale('en_US', () {
        setState(() {
          S.load(Locale('en_US'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    } else {
      Prefs().setLocale('$ceklanguage', () {
        setState(() {
          S.load(Locale('$ceklanguage'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    }
  }

  Future<void> _postEndRoom() async {
    debugPrint('pos end');
    if (_isPosting) return;
    setState(() => _isPosting = true);

    final dio = Dio();
    var apiUrl = '${ApiEndpoint.baseUrl}/api/consultation/post-end-room';
    final formData = FormData.fromMap({
      'consultation_id': widget.idUser,
      'is_status': true,
    });

    try {
      final response = await dio.post(apiUrl, data: formData);
      if (response.data['success'] == true) {
        print(response.data['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
      debugPrint('Error posting data: $e');
    } finally {
      setState(() => _isPosting = false);
    }
  }
  // Future<void> _postEndRoom() async {
  //   if (_isPosting) return; // Cegah pemanggilan API berulang kali
  //   setState(() => _isPosting = true);

  //   final dio = Dio();
  //   const apiUrl =
  //       'https://cool-staging.dschazy.com/api/consultation/post-end-room';

  //   try {
  //     final response = await dio.post(apiUrl);
  //     if (response.data['success'] == true) {
  //       print(response.data['message']); // Menampilkan pesan sukses
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(response.data['message'])),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error posting data: $e');
  //   } finally {
  //     setState(() => _isPosting = false);
  //   }
  // }

  int remainingSeconds = 0;
  Timer? _timer;
  void _startCountdown() {
    debugPrint('testing post $_remainingSeconds');

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
        _startCountdown();
      }
    });
  }

  Future<void> fetchDurationFromApi(String id) async {
    try {
      final response = await Dio().get(
          '${ApiEndpoint.baseUrl}/api/consultation/get-start-room/$id'); // Ganti dengan URL API Anda

      if (response.statusCode == 200) {
        final int duration =
            response.data['data']['duration']; // Ambil nilai duration dari JSON
        setState(() {
          _remainingSeconds = duration * 60; // Ubah menit ke detik
        });
        _startCountdownn();
      }
    } catch (e) {
      debugPrint('Error fetching duration: $e');
    }
  }

  /// Fungsi untuk memulai timer countdown
  void _startCountdownn() {
    if (_remainingSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingSeconds > 0) {
          setState(() {
            _remainingSeconds--;
          });
        } else {
          _timer?.cancel();
          _postEndRoom();
          isVisibleChat = true;
        }
      });
    }
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref('${widget.user} $name');
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text('Chat'),
          leading: IconButton(
              onPressed: () {
                Nav.to(NavMenuScreen());
              },
              icon: Icon(Icons.arrow_back)),
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
                          : 'Archieve',
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
            // Chat
            Expanded(
              child: StreamBuilder<types.Room>(
                initialData: widget.room,
                stream: FirebaseChatCore.instance.room(widget.room.id),
                builder: (context, snapshot) =>
                    StreamBuilder<List<types.Message>>(
                  initialData: const [],
                  stream: FirebaseChatCore.instance.messages(snapshot.data!),
                  builder: (context, snapshot) => Chat(
                    isAttachmentUploading: _isAttachmentUploading,
                    messages: snapshot.data ?? [],
                    onAttachmentPressed:
                        _remainingSeconds > 0 ? _handleAtachmentPressed : null,
                    onMessageTap: _handleMessageTap,
                    onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: _remainingSeconds > 0
                        ? _handleSendPressed
                        : (message) {},
                    user: types.User(
                      id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                    ),
                    inputOptions: isVisibleChat == false
                        ? const InputOptions(enabled: true)
                        : const InputOptions(enabled: false),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: StreamBuilder<types.Room>(
            //     initialData: widget.room,
            //     stream: FirebaseChatCore.instance.room(widget.room.id),
            //     builder: (context, snapshot) =>
            //         StreamBuilder<List<types.Message>>(
            //       initialData: const [],
            //       stream: FirebaseChatCore.instance.messages(snapshot.data!),
            //       builder: (context, snapshot) => Chat(
            //         isAttachmentUploading: _isAttachmentUploading,
            //         messages: snapshot.data ?? [],
            //         onAttachmentPressed: _handleAtachmentPressed,
            //         onMessageTap: _handleMessageTap,
            //         onPreviewDataFetched: _handlePreviewDataFetched,
            //         onSendPressed: _handleSendPressed,
            //         user: types.User(
            //           id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
}

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           systemOverlayStyle: SystemUiOverlayStyle.light,
//           title: const Text('Chat'),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                     border: Border.all(
//                       color: _remainingSeconds > 0 ? Colors.blue : Colors.red,
//                       width: 5,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(2),
//                     child: Text(
//                       _remainingSeconds > 0
//                           ? _formatTime(_remainingSeconds)
//                           : 'Archieve',
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: _remainingSeconds > 0 ? Colors.blue : Colors.red,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: StreamBuilder<types.Room>(
//           initialData: widget.room,
//           stream: FirebaseChatCore.instance.room(widget.room.id),
//           builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
//             initialData: const [],
//             stream: FirebaseChatCore.instance.messages(snapshot.data!),
//             builder: (context, snapshot) => Chat(
//               isAttachmentUploading: _isAttachmentUploading,
//               messages: snapshot.data ?? [],
//               onAttachmentPressed: _handleAtachmentPressed,
//               onMessageTap: _handleMessageTap,
//               onPreviewDataFetched: _handlePreviewDataFetched,
//               onSendPressed: _handleSendPressed,
//               user: types.User(
//                 id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
//               ),
//             ),
//           ),
//         ),
//       );
// }
