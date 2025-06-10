import 'dart:io';

import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/Konsultasi/Normal_User/rating.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class ChatBoxReport extends StatefulWidget {
  String? status;
  String? name;
  String? body;
  String? media;
  String? appVersion;
  String? tanggal;
  String? id_log;
  ChatBoxReport({
    this.status,
    this.name,
    this.body,
    this.media,
    this.appVersion,
    this.tanggal,
    this.id_log,
    Key? key,
  }) : super(key: key);



  @override
  _ChatBoxReportState createState() => _ChatBoxReportState();
}

class _ChatBoxReportState extends State<ChatBoxReport> {
  File? _pickedImage; // Tambahkan di atas
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

  TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int _remainingSeconds = 6; // Waktu lebih pendek untuk testing
  bool _isRecording = false;
  FlutterSoundRecorder? _audioRecorder;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initializeRecorder();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProviderUser>();
      provider.getMassageReport(
        context,
        widget.id_log, // ID laporan
      );
    });
  }


  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
    _scrollController.dispose();
    _controller.dispose();
    if (_audioRecorder != null) {
      _audioRecorder!.closeRecorder();
    }
    super.dispose();
  }




  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
      // Langsung kirim gambar tanpa teks
      _sendMessage();
    }
  }


  Future<void> _pickFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
      // Langsung kirim gambar tanpa teks
      _sendMessage();
    }
  }


  void _sendMessage() async {
    final String? idLog = widget.id_log;
    final String idReceiver = "1";
    final String message = _controller.text.trim();

    if (message.isEmpty && _pickedImage == null) return;
    if (_remainingSeconds <= 0) return;

    final provider = context.read<ProviderUser>();
    await provider.sendMassageReportProvider(
      context,
      idLog: idLog ?? "0",
      idReceiver: idReceiver,
      message: message,
      image: _pickedImage,
    );

    if (provider.sendMassageResponse?.success == true) {
      _controller.clear();
      _pickedImage = null; // Reset image
      provider.getMassageReport(context,widget.id_log);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderUser>(
      builder: (context, value, child) {
        if (!value.isLoadingMassageReport) {
          _scrollToBottom();
        }
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  color: _getColorForContainer(widget.status ?? ""),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0,top: 10,left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.name ?? "" ,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),
                            ),
                            Spacer(),
                            Text(
                              widget.tanggal ?? "",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        gapH10,
                        statusRow(S.of(context).status, widget.status ?? ""),
                        statusRow(S.of(context).gambar, widget?.media != null ? S.of(context).ada : S.of(context).tidakAda),
                        statusRow(S.of(context).versiAplikasi, widget?.appVersion ?? S.of(context).tidakTersedia),
                        SizedBox(height: 8),
                        Text(
                          widget?.body ?? " ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        gapH10,
                        Divider()
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: value.isLoadingMassageReport
                      ? Center(child: CircularProgressIndicator())
                      : (value.massageReportData?.data?.messages?.isEmpty ?? true)
                      ? Center(child: Text(S.of(context).no_data))
                      : ListView.builder(
                    controller: _scrollController,
                    itemCount: value.massageReportData?.data?.messages?.length ?? 0,
                    itemBuilder: (context, index) {
                      final message = value.massageReportData!.data!.messages![index];
                      // Asumsi: senderId 1 adalah user
                      bool isUser = message.senderId == 1;

                      return Align(
                        alignment: isUser
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: message.text == null ? SizedBox(
                              height: 200,
                              child: Image.network(message.image)) : Text(message.text ?? ""),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
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
                      value.isLoadingSendMassage ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator( backgroundColor: primaryColor,)),
                      ) : IconButton(
                        icon: Icon(
                          Icons.send,
                          color: BlueColor,
                        ),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget statusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  Color _getColorForContainer(String type) {
    switch (type) {
      case 'On Progress':
        return Color(0xFFFCE4D0);
      case 'Done':
        return Color(0xFFCCFBD3);
      case 'Sent To Admin':
        return Colors.white;
      case 'Closed':
        return Colors.red.shade100;
      default:
        return Colors.white; // Warna default jika type tidak cocok
    }
  }
}
