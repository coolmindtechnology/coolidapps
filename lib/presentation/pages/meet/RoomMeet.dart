import 'package:coolappflutter/data/provider/provider_meet.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final String userName;

  const VideoConferencePage({
    super.key,
    required this.conferenceID,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: ZegoConfig
            .appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: ZegoConfig
            .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userName,
        userName: userName,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(
          audioVideoViewConfig: ZegoPrebuiltAudioVideoViewConfig(
            foregroundBuilder: (context, size, user, extraInfo) {
              return user != null
                  ? Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://your_server/app/avatar/${user.id}.png'),
                    ),
                  ),
                ),
              )
                  : const SizedBox();
            },
          ),
          bottomMenuBarConfig: ZegoBottomMenuBarConfig(
            buttons: [
              ZegoMenuBarButtonName.chatButton,
              ZegoMenuBarButtonName.leaveButton,
              ZegoMenuBarButtonName.toggleMicrophoneButton,
              ZegoMenuBarButtonName.toggleScreenSharingButton,
              ZegoMenuBarButtonName.toggleCameraButton,
            ],
          ),
        ),
      ),
    );
  }
}
