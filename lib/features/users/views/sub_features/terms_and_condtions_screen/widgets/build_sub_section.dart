import 'package:flutter/material.dart';

class BuildSubSection extends StatefulWidget {
  final String title;
  final String content;
  const BuildSubSection({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  State<BuildSubSection> createState() => _BuildSubSectionState();
}

class _BuildSubSectionState extends State<BuildSubSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.content,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}
