import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/admin/admin_bloc/admin_bloc.dart';
import 'package:teen_splash/features/users/views/private_chat_screen.dart';
import 'package:teen_splash/features/users/views/scrolling_text.dart';
import 'package:teen_splash/model/ticker_notification_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/search_field.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late final AdminBloc adminBloc;
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = "";

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.tickerNotifications.isEmpty) {
      adminBloc.add(
        GetTickerNotification(),
      );
    }
    super.initState();
    searchController.addListener(
      () {
        setState(
          () {
            searchQuery = searchController.text.trim();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String cuid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
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
          title: Text(
            'Chats',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.surface,
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
      body: SafeArea(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: SearchField(
                controller: searchController,
              ),
            ),
            Gaps.hGap20,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chats')
                    .where('participants', arrayContains: cuid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No chats available"));
                  }

                  final chatDocs = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    itemCount: chatDocs.length,
                    itemBuilder: (context, index) {
                      final chat = chatDocs[index];
                      final chatId = chat.id;

                      final lastMessage =
                          chat['lastMessage'] ?? 'No messages yet';
                      final lastMessageTimestamp = chat['lastTimestamp'];
                      final lastMessageType = chat['lastMessageType'];
                      final unreadCountField = 'unreadCount.$cuid';
                      final chatData = chat.data() as Map<String, dynamic>;
                      final unreadCount = chatData.containsKey(unreadCountField)
                          ? chatData[unreadCountField]
                          : 0;
                      String formattedTime = '';
                      if (lastMessageTimestamp != null) {
                        DateTime lastMessageDateTime =
                            lastMessageTimestamp is Timestamp
                                ? lastMessageTimestamp.toDate()
                                : lastMessageTimestamp;

                        final timeDifference =
                            DateTime.now().difference(lastMessageDateTime);
                        if (timeDifference.inSeconds < 60) {
                          formattedTime = '${timeDifference.inSeconds} sec ago';
                        } else if (timeDifference.inMinutes < 60) {
                          formattedTime = '${timeDifference.inMinutes} min ago';
                        } else if (timeDifference.inHours < 24) {
                          formattedTime = '${timeDifference.inHours} hours ago';
                        } else if (timeDifference.inDays < 7) {
                          formattedTime = '${timeDifference.inDays} days ago';
                        } else {
                          formattedTime = DateFormat('MMM d, yyyy')
                              .format(lastMessageDateTime);
                        }
                      }

                      return FutureBuilder<QuerySnapshot>(
                        future: _firestore
                            .collection('chats')
                            .doc(chatId)
                            .collection('messages')
                            .orderBy('timestamp', descending: true)
                            .limit(1)
                            .get(),
                        builder: (context, messageSnapshot) {
                          if (messageSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (messageSnapshot.hasError ||
                              messageSnapshot.data == null) {
                            return const Center(
                              child: Text('Error loading message.'),
                            );
                          }
                          final latestMessage =
                              messageSnapshot.data!.docs.first;
                          final senderId = latestMessage['senderId'] ?? '';
                          final senderName = latestMessage['senderName'] ?? '';
                          final senderProfileUrl = latestMessage['profileUrl'];
                          final recieverId = latestMessage['recieverId'] ?? '';
                          final recieverName =
                              latestMessage['recieverName'] ?? '';
                          final recieverProfileUrl =
                              latestMessage['recieverProfileUrl'];
                          final name =
                              senderId == cuid ? recieverName : senderName;
                          if (searchQuery.isNotEmpty &&
                              !name
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase())) {
                            return const SizedBox();
                          }

                          ImageProvider<Object> getProfileImage() {
                            final profileUrl = senderId == cuid
                                ? recieverProfileUrl
                                : senderProfileUrl;
                            if (profileUrl.isEmpty ||
                                profileUrl == "null" ||
                                (Uri.tryParse(profileUrl)?.hasAbsolutePath !=
                                    true)) {
                              return const AssetImage('assets/images/user.png');
                            } else {
                              return NetworkImage(profileUrl);
                            }
                          }

                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (
                                        context,
                                      ) =>
                                          PrivateChatScreen(
                                        chatUserId: senderId == cuid
                                            ? recieverId
                                            : senderId,
                                        chatUserName: senderId == cuid
                                            ? recieverName
                                            : senderName,
                                        chatUserProfileUrl: senderId == cuid
                                            ? recieverProfileUrl
                                            : senderProfileUrl,
                                      ),
                                    ),
                                  );
                                  await FirebaseFirestore.instance
                                      .collection('chats')
                                      .doc(chatId)
                                      .set(
                                    {
                                      'unreadCount.$cuid': 0,
                                    },
                                    SetOptions(merge: true),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 52,
                                      width: 52,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: getProfileImage(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          senderId == cuid
                                              ? '@$recieverName'
                                              : '@$senderName',
                                          style: TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Gaps.hGap05,
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            lastMessageType == 'image'
                                                ? 'Image'
                                                : lastMessage,
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          formattedTime,
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        Gaps.hGap05,
                                        unreadCount > 0
                                            ? Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    unreadCount.toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.hGap15,
                              Divider(
                                thickness: 0.5,
                                color: const Color(0Xff000000).withOpacity(0.1),
                              ),
                              Gaps.hGap15,
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
