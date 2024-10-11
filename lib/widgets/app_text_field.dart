import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.isSearchIcon = false,
    this.hintTextColor = const Color(0xFF999999),
    this.isDropdownIcon = false,
    this.fillColor = const Color(0xFFF4F4F4),
    this.iconImageAddress,
    this.isPrefixIcon = false,
    this.onTapDropdown,
    this.prefixIconColor = const Color(0xFF999999),
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isSearchIcon;
  final bool isDropdownIcon;
  final Color hintTextColor;
  final Color fillColor;
  final String? iconImageAddress;
  final bool isPrefixIcon;
  final VoidCallback? onTapDropdown;
  final Color prefixIconColor;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObsecure = false;
  @override
  void initState() {
    _isObsecure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: _isObsecure,
      validator: widget.validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 13,
        ),
        filled: true,
        prefixIcon: widget.isPrefixIcon
            ? Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: ImageIcon(
                  color: widget.prefixIconColor,
                  AssetImage(
                    widget.iconImageAddress.toString(),
                  ),
                ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(
                    () {
                      _isObsecure = !_isObsecure;
                    },
                  );
                },
                icon: Icon(
                  size: 24,
                  _isObsecure
                      ? Icons.remove_red_eye_outlined
                      : CupertinoIcons.eye_slash,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : widget.isSearchIcon
                ? Icon(
                    size: 25,
                    color: Theme.of(context).colorScheme.surface,
                    CupertinoIcons.search,
                  )
                : widget.isDropdownIcon
                    ? IconButton(
                        onPressed: widget.onTapDropdown,
                        icon: ImageIcon(
                          size: 24,
                          color: Theme.of(context).colorScheme.secondary,
                          const AssetImage(
                            'assets/icons/arrow.png',
                          ),
                        ),
                      )
                    : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: widget.hintTextColor,
        ),
        isDense: true,
        fillColor: widget.fillColor,
      ),
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
