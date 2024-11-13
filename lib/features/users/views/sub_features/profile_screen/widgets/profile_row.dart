import 'package:flutter/material.dart';

class ProfileRow extends StatefulWidget {
  final String title;
  final String content;
  const ProfileRow({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  State<ProfileRow> createState() => _ProfileRowState();
}

class _ProfileRowState extends State<ProfileRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Spacer(),
        Text(
          widget.content,
          style: const TextStyle(
            fontFamily: 'Lexend',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(
              0xFF999999,
            ),
          ),
        ),
      ],
    );
  }
}
