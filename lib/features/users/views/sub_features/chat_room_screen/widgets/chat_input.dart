import 'package:flutter/material.dart';
import 'package:teen_splash/widgets/app_text_field.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onSendText;
  final VoidCallback onSendCameraImage;
  final VoidCallback onSendGalleryImage;
  const ChatInput({
    required this.messageController,
    required this.onSendText,
    required this.onSendCameraImage,
    required this.onSendGalleryImage,
    super.key,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(-4, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => widget.onSendGalleryImage(),
              child: Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/clip.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppTextField(
                controller: widget.messageController,
                isCopyIcon: true,
                hintText: 'Write your message',
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => widget.onSendCameraImage(),
              child: Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/cam.png'),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                color: Theme.of(context).colorScheme.secondary,
                Icons.send,
              ),
              onPressed: () => widget.onSendText(),
            ),
          ],
        ),
      ),
    );
  }
}
