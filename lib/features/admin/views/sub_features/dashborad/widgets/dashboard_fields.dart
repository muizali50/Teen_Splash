import 'package:flutter/material.dart';

class DashboardFields extends StatefulWidget {
  const DashboardFields({
    super.key,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    required this.title,
    required this.titleColor,
    required this.containerColor,
  });

  final String? icon;
  final VoidCallback? onTap;
  final int? iconColor;
  final String? title;
  final int? titleColor;
  final int? containerColor;

  @override
  State<DashboardFields> createState() => _DashboardFieldsState();
}

class _DashboardFieldsState extends State<DashboardFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        color: Color(
          widget.containerColor!.toInt(),
        ),
        borderRadius: BorderRadius.circular(
          9,
        ),
      ),
      child: ListTile(
        dense: true,
        leading: ImageIcon(
          color: Color(
            widget.iconColor!.toInt(),
          ),
          AssetImage(
            widget.icon.toString(),
          ),
        ),
        // leading: Icon(
        //   widget.icon,
        //   color: Color(
        //     widget.iconColor!.toInt(),
        //   ),
        // ),
        title: Text(
          widget.title.toString(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(
              widget.titleColor!.toInt(),
            ),
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
