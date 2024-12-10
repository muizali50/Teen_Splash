import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  final String imageUrl;
  const ImageDialog({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      width: 640,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            widget.imageUrl,
          ),
        ),
      ),
    );
  }
}
