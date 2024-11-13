import 'package:flutter/material.dart';

class BuildSection extends StatefulWidget {
  final String title;
  final String content;
  const BuildSection({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  State<BuildSection> createState() => _BuildSectionState();
}

class _BuildSectionState extends State<BuildSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.content,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}
