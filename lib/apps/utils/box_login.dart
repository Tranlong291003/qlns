import 'package:flutter/material.dart';

class BoxSign extends StatefulWidget {
  final TextEditingController controller;

  final String hintText;
  final bool obscureText;
  const BoxSign({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
  });

  @override
  _BoxSignState createState() => _BoxSignState();
}

class _BoxSignState extends State<BoxSign> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText; // Khởi tạo giá trị từ thuộc tính widget
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      width: 357,
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.secondary,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: _obscureText,
        maxLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          isCollapsed: true,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Chuyển đổi trạng thái ẩn/hiện mật khẩu
                    });
                  },
                )
              : null, // Nếu không cần chế độ ẩn mật khẩu, bỏ qua suffixIcon
        ),
      ),
    );
  }
}
