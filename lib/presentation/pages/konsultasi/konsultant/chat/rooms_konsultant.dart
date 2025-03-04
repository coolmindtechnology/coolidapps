import 'dart:async';

import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/chat.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/users.dart';
import 'package:coolappflutter/presentation/pages/konsultasi/normal_user/chat/firebase_chat/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class RoomsPageKonsultan extends StatefulWidget {
  const RoomsPageKonsultan({super.key, required this.idUser});
  final String idUser;

  @override
  State<RoomsPageKonsultan> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPageKonsultan> {
  bool _error = false;
  bool _initialized = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _initializeFlutterFire();
  }

  /// Initialize Firebase and listen to auth state changes
  Future<void> _initializeFlutterFire() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (mounted) {
          setState(() {
            _user = user;
            _initialized = true; // Firebase initialized
          });

          // Fetch fresh data after login
          if (user != null) {
            FirebaseChatCore.instance.rooms().first.then((rooms) {
              debugPrint('Rooms fetched: $rooms');
              debugPrint('User ID: ${user.uid}');
            });
          }
        }
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
      debugPrint('Initialization error: $e');
    }
  }

  /// Logout function with state reset
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        setState(() {
          _user = null; // Reset user state
        });
      }
    } catch (e) {
      debugPrint('Logout failed: $e');
    }
  }

  /// Build avatar for the room
  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere((u) => u.id != _user?.uid);
        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        debugPrint('Error finding other user: $e');
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '',
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return const Scaffold(
        body: Center(
          child: Text('An error occurred during initialization'),
        ),
      );
    }

    if (!_initialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // if (_user == null) {
    //   return const LoginPage();
    // }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.chat,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => UsersPage(
                    idUser: widget.idUser,
                  ),
                ),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('CoolChat'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No rooms available'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        idUser: widget.idUser,
                        room: room,
                        user: _user?.email,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          _buildAvatar(room),
                          Expanded(
                            child: Text(
                              room.name ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
