import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teen_splash/features/users/views/private_chat_screen.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/search_field.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
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
                stream: _firestore.collection('chats').snapshots(),
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

                      // Get the last message
                      final lastMessage =
                          chat['lastMessage'] ?? 'No messages yet';
                      final lastMessageTimestamp = chat[
                          'lastTimestamp']; // Assuming it's a Timestamp field

                      // Format the last message time
                      String formattedTime = '';
                      if (lastMessageTimestamp != null) {
                        // If it's a Firestore Timestamp, convert it to DateTime
                        DateTime lastMessageDateTime =
                            lastMessageTimestamp is Timestamp
                                ? lastMessageTimestamp.toDate()
                                : lastMessageTimestamp;

                        final timeDifference =
                            DateTime.now().difference(lastMessageDateTime);

                        // Show time difference in minutes, if less than 60 minutes
                        if (timeDifference.inMinutes < 60) {
                          formattedTime = '${timeDifference.inMinutes} min ago';
                        }
                        // Show time difference in hours, if less than 24 hours
                        else if (timeDifference.inHours < 24) {
                          formattedTime = '${timeDifference.inHours} hours ago';
                        }
                        // Show time difference in days, if less than 7 days
                        else if (timeDifference.inDays < 7) {
                          formattedTime = '${timeDifference.inDays} days ago';
                        }
                        // Show the exact date if more than 7 days have passed
                        else {
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
                          final id = latestMessage['senderId'] ?? '';
                          final name = latestMessage['senderName'] ?? '';
                          final profileUrl = latestMessage['profileUrl'];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (
                                        context,
                                      ) =>
                                          PrivateChatScreen(
                                        chatUserId: id,
                                        chatUserName: name,
                                        chatUserProfileUrl: profileUrl,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 52,
                                      width: 52,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            'https://plus.unsplash.com/premium_photo-1722945691819-e58990e7fb27?q=80&w=1442&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                          ),
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
                                          '@$name',
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
                                        Text(
                                          lastMessage,
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
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
                                        // unreadCount > 0
                                        //     ?
                                        Container(
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
                                              '2',
                                              style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 8,
                                                fontWeight: FontWeight.w800,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                              ),
                                            ),
                                          ),
                                        )
                                        // : const SizedBox(),
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
