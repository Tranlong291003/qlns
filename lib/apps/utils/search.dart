import 'package:flutter/material.dart';

Padding search(BuildContext context, void Function(String) onSearchChanged) {
  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 30, top: 10),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent, // Màu nền của Container
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          suffixIcon: Image.asset(
            'assets/images/Icon/search.png',
            color: Colors.black, // Màu biểu tượng tìm kiếm
          ),
          hintText: 'Search ', // Văn bản gợi ý
          hintStyle: TextStyle(
            color: Colors.grey[600], // Màu sắc của văn bản gợi ý
          ),
          filled: true,
          fillColor: Colors.grey[259], // Màu nền của ô input (thanh tìm kiếm)
          border: InputBorder.none, // Bỏ viền của TextField
          contentPadding: const EdgeInsets.only(left: 20),
        ),
        textInputAction: TextInputAction.search,
        onChanged: onSearchChanged, // Gọi hàm khi người dùng thay đổi văn bản
      ),
    ),
  );
}
