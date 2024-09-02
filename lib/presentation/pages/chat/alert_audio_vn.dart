import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'audio_player.dart';
import 'audio_recorder.dart';

class AlertVoiceNote extends StatefulWidget {
  Function(String resultAudio,bool audioPause)? onVn;
  AlertVoiceNote({super.key, this.onVn});

  @override
  State<AlertVoiceNote> createState() => _AlertVoiceNoteState();
}

class _AlertVoiceNoteState extends State<AlertVoiceNote> {
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(10),
      content: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: showPlayer
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AudioPlayerVoiceNote(
                      source: audioPath!,
                      onDelete: () {
                        setState(() => showPlayer = false);
                      },
                    ),
                    ButtonPrimary(
                      S.of(context).next,
                      onPress: () {
                        widget.onVn!(audioPath!, showPlayer);
                        Nav.back();
                      },
                      elevation: 0.0,
                      radius: 8,
                    ),
                  ],
                ),
              )
            : Recorder(
                onStop: (path) {
                  if (kDebugMode) print('Recorded file path: $path');
                  setState(() {
                    audioPath = path;
                    widget.onVn!(path, showPlayer);
                    showPlayer = true;
                  });
                },
              ),
      ),
    );
  }
}
