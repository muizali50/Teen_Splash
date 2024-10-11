import 'package:flutter/material.dart';

class DrawerRow extends StatefulWidget {
  final String iconImage;
  final String title;
  final VoidCallback onTap;
  const DrawerRow({
    required this.iconImage,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  State<DrawerRow> createState() => _DrawerRowState();
}

class _DrawerRowState extends State<DrawerRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        children: [
          ImageIcon(
            color: Theme.of(context).colorScheme.tertiary,
            AssetImage(
              widget.iconImage,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
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
          ImageIcon(
            color: Theme.of(context).colorScheme.secondary,
            const AssetImage(
              'assets/icons/forward.png',
            ),
          ),
        ],
      ),
    );
  }
}
