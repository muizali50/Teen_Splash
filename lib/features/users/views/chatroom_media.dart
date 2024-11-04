import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/full_screen_image.dart';
import 'package:teen_splash/utils/gaps.dart';

class ChatroomMedia extends StatefulWidget {
  const ChatroomMedia({super.key});

  @override
  State<ChatroomMedia> createState() => _ChatroomMediaState();
}

class _ChatroomMediaState extends State<ChatroomMedia> {
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
            'Chatroom',
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
            Gaps.hGap40,
            Center(
              child: Text(
                '1k+ Members',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Gaps.hGap20,
            Center(
              child: Text(
                'Media',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Gaps.hGap40,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chatroom')
                    .where('messageType',
                        isEqualTo: 'image') // Only fetch image messages
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final imageMessages = snapshot.data!.docs;
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    itemCount: imageMessages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // mainAxisExtent: 120,
                      crossAxisCount: 4,
                      // mainAxisSpacing: 50.0,
                    ),
                    itemBuilder: (context, index) {
                      final imageUrl =
                          imageMessages[index]['message']; // Get image URL
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullScreenImage(imageUrl: imageUrl),
                            ),
                          );
                        },
                        child: Container(
                          height: 83,
                          width: 83,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(
                                0xFFD9D9D9,
                              ),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                imageUrl,
                              ),
                            ),
                          ),
                        ),
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
