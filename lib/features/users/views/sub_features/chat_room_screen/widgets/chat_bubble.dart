import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/full_screen_image.dart';
import 'package:teen_splash/features/users/views/other_person_profile.dart';
import 'package:teen_splash/model/chat_message.dart';
import 'package:teen_splash/utils/gaps.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage chatMessage;
  final bool? isGuest;
  const ChatBubble({
    required this.chatMessage,
    this.isGuest,
    super.key,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    bool isSentByCurrentUser = widget.chatMessage.senderId ==
        (FirebaseAuth.instance.currentUser?.uid ?? '');
    // bool isSentByCurrentUser =
    //     widget.chatMessage.senderId == FirebaseAuth.instance.currentUser!.uid;
    return isSentByCurrentUser
        ? Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.chatMessage.messageType == 'image'
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (
                                context,
                              ) =>
                                  FullScreenImage(
                                imageUrl: widget.chatMessage.message,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'background-${widget.chatMessage.message}',
                          child: Container(
                            height: 122,
                            width: 192,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.chatMessage.message,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                          ), // Max width for message
                          child: Text(
                            widget.chatMessage.message,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _formatTimestamp(widget.chatMessage.timestamp),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtherPersonProfile(
                        chatUserId: widget.chatMessage.senderId,
                        chatUserName: widget.chatMessage.senderName,
                        chatUserProfileUrl: widget.chatMessage.profileUrl,
                        isGuest: widget.isGuest,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _getProfileImage(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 22,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.chatMessage.senderName}  ${widget.chatMessage.countryFlagUrl}',
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000E08),
                    ),
                  ),
                  Gaps.hGap10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.chatMessage.messageType == 'image'
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                      context,
                                    ) =>
                                        FullScreenImage(
                                      imageUrl: widget.chatMessage.message,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'background-${widget.chatMessage.message}',
                                child: Container(
                                  height: 122,
                                  width: 192,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        widget.chatMessage.message,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 200,
                                ), // Max width for message
                                child: Text(
                                  widget.chatMessage.message,
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _formatTimestamp(widget.chatMessage.timestamp),
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} ${timestamp.hour >= 12 ? 'PM' : 'AM'}';
  }

  ImageProvider<Object> _getProfileImage() {
    final profileUrl = widget.chatMessage.profileUrl;
    // Check if profileUrl is empty, "null" string, or not a valid URL
    if (profileUrl.isEmpty ||
        profileUrl == "null" ||
        (Uri.tryParse(profileUrl)?.hasAbsolutePath != true)) {
      return const AssetImage('assets/images/user.png');
    } else {
      return NetworkImage(profileUrl);
    }
  }
}
