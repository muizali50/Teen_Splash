import 'package:flutter/material.dart';

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isBorder = false,
    this.isBorderColor = const Color(0xFFffffff),
    this.hintTextColor = const Color(0xFFffffff),
    this.isPrimaryColor = false,
    this.primaryColor = const Color(0xFF272575),
  });

  final String text;
  final VoidCallback onTap;
  final bool isBorder;
  final Color isBorderColor;
  final Color hintTextColor;
  final bool isPrimaryColor;
  final Color primaryColor;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  // bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12),
      // onHover: (value) {
      //   setState(
      //     () {
      //       _isHovering = value;
      //     },
      //   );
      // },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: widget.isPrimaryColor ? widget.primaryColor : null,
          gradient: widget.isBorder || widget.isPrimaryColor
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                ),
          border: widget.isBorder
              ? Border.all(
                  color: widget.isBorderColor,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: widget.hintTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
