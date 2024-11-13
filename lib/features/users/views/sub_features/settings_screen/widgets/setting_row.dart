import 'package:flutter/material.dart';

class SettingRow extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  const SettingRow({
    required this.onTap,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  State<SettingRow> createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          ImageIcon(
            color: Theme.of(context).colorScheme.secondary,
            AssetImage(
              widget.icon,
            ),
          ),
        ],
      ),
    );
  }
}
