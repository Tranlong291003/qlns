import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildInfoTile(IconData icon, String title, String value) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    ),
  );
}
