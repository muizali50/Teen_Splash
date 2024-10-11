import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  const SearchField({
    required this.controller,
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // Set height for the search field
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(8), // Border radius of 8
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // 8% opacity shadow
            blurRadius: 16, // Blur of 16
            offset: const Offset(0, 2), // y = 2
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0), // Padding for the icon
            child: ImageIcon(
              color: Color(0xFF999999),
              AssetImage(
                'assets/icons/search.png',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 7.0),
            child: VerticalDivider(
              color: Color(0xFFDADADA), // Divider color (change if needed)
              thickness: 1, // Thickness of the divider
              width: 12, // Space around the divider
            ),
          ),
          Expanded(
            // Allows the TextField to expand
            child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                hintText: 'Search', // Hint text
                border: InputBorder.none, // No border
                hintStyle: TextStyle(
                  color: Colors.grey, // Hint text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
