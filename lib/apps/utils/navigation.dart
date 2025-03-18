import 'package:flutter/material.dart';

// Hàm tạo route tùy chỉnh với animation
PageRouteBuilder createCustomPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Animation trượt từ phải sang trái
      const begin = Offset(1.0, 0.0); // Vị trí bắt đầu
      const end = Offset.zero; // Vị trí kết thúc (trang đến vị trí gốc)
      const curve = Curves.easeInOut; // Hiệu ứng curve

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
