import 'package:flutter/material.dart';
import 'package:qlns/screens/employee/employee_screen.dart';
import 'package:qlns/screens/homeScreen.dart';
import 'package:qlns/screens/scheduleScreen.dart';
import 'package:qlns/screens/taskScreen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  // Chỉ mục của mục đã chọn trong thanh điều hướng
  int _selectedIndex = 0;

  // Các màn hình cho từng mục điều hướng
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    EmployeeManagementScreen(),
    TaskScreen(),
    ScheduleScreen(),
  ];

  // Hàm khi chọn một mục trong BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật chỉ mục đã chọn
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _widgetOptions[_selectedIndex], // Hiển thị trang tương ứng với mục đã chọn
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Chỉ mục hiện tại
        onTap: _onItemTapped, // Gọi hàm khi chọn mục
        selectedItemColor: Colors.blue, // Màu của mục đã chọn
        unselectedItemColor: Colors.grey, // Màu của mục chưa chọn
        backgroundColor: Colors.white, // Màu nền của BottomNavigationBar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people_outlined),
            label: 'Nhân sự',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Công việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Lịch làm việc',
          ),
        ],
      ),
    );
  }
}
