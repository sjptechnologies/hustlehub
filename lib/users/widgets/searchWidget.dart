import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';


class SearchWidget extends StatefulWidget {
  final Function(String)? onSearchChanged; // Callback function to notify parent

  const SearchWidget({super.key, this.onSearchChanged});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        // Call the callback function with the current value
        if (widget.onSearchChanged != null) {
          widget.onSearchChanged!(value);
        }
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: ktextColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ktextColor, // Change the border color
            width: 0.5, // Change the border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Optional: set border radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ktextColor, // Change the border color
            width: 1.0, // Change the border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Optional: set border radius
        ),
        hintText: "Search Job, Company and Role",
        hintStyle: const TextStyle(
          color: ktextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
