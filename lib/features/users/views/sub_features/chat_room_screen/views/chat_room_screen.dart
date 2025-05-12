import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/authentication/bloc/authentication_bloc.dart';
import 'package:teen_splash/features/users/user_bloc/user_bloc.dart';
import 'package:teen_splash/features/users/views/scrolling_text.dart';
import 'package:teen_splash/features/users/views/sub_features/chat_room_screen/widgets/chat_bubble.dart';
import 'package:teen_splash/features/users/views/sub_features/chat_room_screen/widgets/chat_input.dart';
import 'package:teen_splash/features/users/views/chatroom_media.dart';
import 'package:teen_splash/features/users/views/chats_screen.dart';
import 'package:teen_splash/model/chat_message.dart';
import 'package:teen_splash/model/push_notification_model.dart';
import 'package:teen_splash/model/ticker_notification_model.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:teen_splash/utils/app_utitls.dart';
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
  late final UserBloc userBloc;
  late final AdminBloc adminBloc;
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  late final UserProvider userProvider;
  late final AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = context.read<AuthenticationBloc>();
    userProvider = context.read<UserProvider>();
    userBloc = context.read<UserBloc>();

    if (widget.isGuest == false) {
      if (userProvider.user == null) {
        authenticationBloc.add(
          const GetUser(),
        );
      }
    }
    if (userBloc.userTokens == null || userBloc.userTokens!.isEmpty) {
      userBloc.add(
        FetchUserTokensEvent(),
      );
    }

    adminBloc = context.read<AdminBloc>();
    if (adminBloc.tickerNotifications.isEmpty) {
      adminBloc.add(
        GetTickerNotification(),
      );
    }
    adminBloc.add(
      GetRestrictedWords(),
    );
    super.initState();
  }

  bool containsRestrictedWords(String message, List<String> restrictedWords) {
    for (String word in restrictedWords) {
      if (message.toLowerCase().contains(word.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  void _showReportMenu(
      BuildContext context, LongPressStartDetails details, String messageId) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(40, 40), // Position of the menu
        Offset.zero & overlay.size, // Full screen size
      ),
      items: [
        const PopupMenuItem(
          height: 25,
          value: 'report',
          child: Text(
            'Report',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    ).then(
      (value) {
        if (value == 'report') {
          _showReportDialog(context, messageId);
        }
      },
    );
  }

  void _showReportDialog(BuildContext context, String messageId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Report Content',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: const Text(
          'Are you sure you want to report this content?',
          style: TextStyle(
            color: Color(0xFF999999),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _reportContent(messageId);
              Navigator.pop(context);
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  final FocusNode _focusNode = FocusNode(); // Create a FocusNode

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose of the FocusNode when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Detect taps anywhere
      onTap: () {
        _focusNode.unfocus(); // Unfocus when tapping outside
      },
      child: Scaffold(
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
              if (widget.isGuest == null)
                Padding(
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
              child: BlocBuilder<AdminBloc, AdminState>(
                builder: (context, state) {
                  final latestPushNotification =
                      adminBloc.tickerNotifications.lastWhere(
                    (noti) => noti.status == 'Active',
                    orElse: () =>
                        TickerNotificationModel(), // Returns null if no active sponsor is found
                  );
                  if (state is GettingTickerNotification) {
                    return const Center(
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                        ),
                      ),
                    );
                  } else if (state is GetTickerNotificationFailed) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  // Check if no valid sponsor data
                  if ((latestPushNotification.title ?? '').isEmpty &&
                      (latestPushNotification.status ?? '').isEmpty) {
                    return const Center(
                      child: Text('No active push notification available'),
                    );
                  }
                  return SizedBox(
                    height: 20,
                    child: HorizontalScrollingText(
                      text: latestPushNotification.title ??
                          'No active notifications available',
                    ),
                  );
                },
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
                        return GestureDetector(
                          onLongPressStart: (details) =>
                              _showReportMenu(context, details, item.id),
                          child: ChatBubble(
                            chatMessage: item,
                            focusNode: _focusNode,
                            isGuest: widget.isGuest != null &&
                                widget.isGuest == true,
                          ),
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
                        isPrimaryColor: true,
                        primaryColor: Colors.white,
                        hintTextColor: Theme.of(context).colorScheme.secondary,
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

  void _sendTextMessage(UserProvider userProvider, String message) async {
    if (message.isNotEmpty) {
      final state = context.read<AdminBloc>().state;
      if (state is GetRestrictedWordsSuccess) {
        if (containsRestrictedWords(
            _messageController.text, state.restrictedWords.words)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your message contains restricted words!"),
            ),
          );
          return;
        }
      }
      final currentUser = userProvider.user;
      if (currentUser != null) {
        await FirebaseMessaging.instance.unsubscribeFromTopic('all_users');
        userProvider.sendTextMessage(
          currentUser.uid.toString(),
          currentUser.name,
          currentUser.picture.toString(),
          currentUser.countryFlag.toString(),
          message,
        );

        await AppUtils().sendChatroomNotification(
          PushNotificationModel(
            title: currentUser.name,
            content: '${currentUser.name} sent a message',
            // userTokens: userBloc.userTokens,
          ),
        );

        await FirebaseMessaging.instance.subscribeToTopic('all_users');
        _messageController.clear();
      }
    }
  }

  Future<void> _sendImageMessage() async {
    if (_selectedImage == null) return;

    final currentUser = userProvider.user;
    if (currentUser != null) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('all_users');
      await userProvider.sendImageMessage(
        currentUser.uid.toString(),
        currentUser.name,
        currentUser.picture.toString(),
        currentUser.countryFlag.toString(),
        _selectedImage!,
      );

      await AppUtils().sendChatroomNotification(
        PushNotificationModel(
          title: currentUser.name,
          content: '${currentUser.name} sent a message',
          // userTokens: userBloc.userTokens,
        ),
      );
      await FirebaseMessaging.instance.subscribeToTopic('all_users');
      setState(
        () {
          _selectedImage = null;
        },
      );
    }
  }

  Future<void> _reportContent(String messageId) async {
    await userProvider.reportMessage(messageId);
  }
}
