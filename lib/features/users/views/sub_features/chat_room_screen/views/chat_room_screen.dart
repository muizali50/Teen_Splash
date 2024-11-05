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
import 'package:teen_splash/widgets/app_primary_button.dart';

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
  File? _selectedImage;
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
                final groupedMessages = _groupMessagesByDate(messages);
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  reverse: true,
                  itemCount: groupedMessages.length,
                  itemBuilder: (context, index) {
                    final item = groupedMessages[index];
                    if (item is String) {
                      // Render date header
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    } else if (item is ChatMessage) {
                      // Render chat bubble
                      return ChatBubble(
                        chatMessage: item,
                        isGuest:
                            widget.isGuest != null && widget.isGuest == true,
                      );
                    }
                    return const SizedBox.shrink();
                  },
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
                      _pickAndPreviewImage(ImageSource.camera),
                  onSendGalleryImage: () =>
                      _pickAndPreviewImage(ImageSource.gallery),
                  messageController: _messageController,
                ),
        ],
      ),
    );
  }

  List<dynamic> _groupMessagesByDate(List<ChatMessage> messages) {
    final List<dynamic> groupedMessages = [];
    String? lastDate;

    for (var message in messages.reversed) {
      // Reverse the order for correct display
      final messageDate = _formatDate(message.timestamp);
      if (messageDate != lastDate) {
        // Add date header at the start of each new date group
        groupedMessages.insert(0, messageDate);
        lastDate = messageDate;
      }
      // Add message after the date header
      groupedMessages.insert(0, message);
    }

    return groupedMessages;
  }

  String _formatDate(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate =
        DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDate == today) {
      return "Today";
    } else if (messageDate == yesterday) {
      return "Yesterday";
    } else {
      // Format other dates (e.g., "MM/dd/yyyy")
      return "${timestamp.month}/${timestamp.day}/${timestamp.year}";
    }
  }

  Future<void> _pickAndPreviewImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(
        () {
          _selectedImage = File(pickedFile.path);
        },
      );

      _showImagePreviewDialog();
    }
  }

  void _showImagePreviewDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero, // Ensures full-screen display
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 106,
                      child: AppPrimaryButton(
                        hintTextColor: Theme.of(context).colorScheme.primary,
                        isBorderColor: Theme.of(context).colorScheme.tertiary,
                        isBorder: true,
                        text: 'Cancel',
                        onTap: () {
                          setState(
                            () {
                              _selectedImage = null; // Discard image
                            },
                          );
                          Navigator.pop(context); // Close dialog
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      height: 50,
                      width: 106,
                      child: AppPrimaryButton(
                        text: 'Send',
                        onTap: () {
                          Navigator.pop(context); // Close dialog
                          _sendImageMessage(); // Send image
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

  Future<void> _sendImageMessage() async {
    if (_selectedImage == null) return;

    final currentUser = userProvider.user;
    if (currentUser != null) {
      await userProvider.sendImageMessage(
        currentUser.uid.toString(),
        currentUser.name,
        currentUser.picture.toString(),
        currentUser.countryFlag.toString(),
        _selectedImage!,
      );

      // Clear the preview after sending
      setState(
        () {
          _selectedImage = null;
        },
      );
    }
  }

  // Future<void> _pickAndSendImage(
  //     UserProvider userProvider, ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     final imageFile = File(pickedFile.path);
  //     final currentUser = userProvider.user;
  //     if (currentUser != null) {
  //       await userProvider.sendImageMessage(
  //         currentUser.uid.toString(),
  //         currentUser.name,
  //         currentUser.picture.toString(),
  //         currentUser.countryFlag.toString(),
  //         imageFile,
  //       );
  //     }
  //   }
  // }
}
