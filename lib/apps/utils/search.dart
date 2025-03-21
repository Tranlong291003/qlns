import 'package:flutter/material.dart';

Padding search(BuildContext context, void Function(String) onSearchChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          suffixIcon: Image.asset(
            'assets/images/Icon/search.png',
            color: Colors.black,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 20),
        ),
        textInputAction: TextInputAction.search,
        onChanged: onSearchChanged,
      ),
    ),
  );
}
