import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/users/views/sub_features/chat_room_screen/widgets/chat_bubble.dart';
import 'package:teen_splash/features/users/views/sub_features/chat_room_screen/widgets/chat_input.dart';
import 'package:teen_splash/features/users/views/chatroom_media.dart';
import 'package:teen_splash/features/users/views/chats_screen.dart';
import 'package:teen_splash/model/chat_message.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:teen_splash/utils/gaps.dart';

class ChatRoomScreen extends StatefulWidget {
  final bool? isGuest;
  const ChatRoomScreen({
    this.isGuest,
    super.key,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    authenticationBloc.add(
      const GetUser(),
    );
    userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      authenticationBloc.add(
        const GetUser(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ImageIcon(
                      color: Theme.of(context).colorScheme.secondary,
                      const AssetImage(
                        'assets/icons/back.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            if (widget.isGuest != null)
              !widget.isGuest!
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: 16.0,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    const ChatsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ImageIcon(
                                color: Theme.of(context).colorScheme.secondary,
                                const AssetImage(
                                  'assets/icons/chat.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
          ],
          title: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      const ChatroomMedia(),
                ),
              );
            },
            child: Text(
              'Chatroom',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Container(
            height: 18,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(
                  12.0,
                ),
                bottomRight: Radius.circular(
                  12.0,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                'Ticker for push notifications to advertise looped updates.',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFBFBFB),
                ),
              ),
            ),
          ),
          Gaps.hGap20,
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: userProvider.getChatMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No messages yet'),
                  );
                }
                final messages = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) => ChatBubble(
                    chatMessage: messages[index],
                    isGuest: widget.isGuest != null && widget.isGuest == true
                        ? true
                        : false,
                  ),
                );
              },
            ),
          ),
          widget.isGuest != null && widget.isGuest! == true
              ? const SizedBox()
              : ChatInput(
                  onSendText: () =>
                      _sendTextMessage(userProvider, _messageController.text),
                  onSendCameraImage: () =>
                      _pickAndSendImage(userProvider, ImageSource.camera),
                  onSendGalleryImage: () =>
                      _pickAndSendImage(userProvider, ImageSource.gallery),
                  messageController: _messageController,
                ),
        ],
      ),
    );
  }

  void _sendTextMessage(UserProvider userProvider, String message) {
    if (message.isNotEmpty) {
      final currentUser = userProvider.user;
      if (currentUser != null) {
        userProvider.sendTextMessage(
          currentUser.uid.toString(),
          currentUser.name,
          currentUser.picture.toString(),
          currentUser.countryFlag.toString(),
          message,
        );
        _messageController.clear();
      }
    }
  }

  Future<void> _pickAndSendImage(
      UserProvider userProvider, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final currentUser = userProvider.user;
      if (currentUser != null) {
        await userProvider.sendImageMessage(
          currentUser.uid.toString(),
          currentUser.name,
          currentUser.picture.toString(),
          currentUser.countryFlag.toString(),
          imageFile,
        );
      }
    }
  }
}
