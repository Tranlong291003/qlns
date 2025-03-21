import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  const CustomAppBar({super.key, required this.title})
    : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            print('Thông báo');
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            print('Cài đặt');
          },
        ),
      ],
    );
  }
}
