import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/customAppBar.dart';
import 'package:qlns/screens/employee_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;

    return Scaffold(
      appBar: CustomAppBar(title: 'True connect '),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Tổng quan công ty',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Bảng thống kê tổng quan
              Row(
                children: <Widget>[
                  Expanded(
                    child: _statCard(
                      cardWidth,
                      'Công việc',
                      '20',
                      'Hoàn thành: 15\nChưa hoàn thành: 5',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      cardWidth,
                      'Nhân sự',
                      '50',
                      'Full-time: 30\nPart-time: 10\nTTS: 10',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _statCard(
                      cardWidth,
                      'Lịch làm việc',
                      '30',
                      'Tại văn phòng: 20\nTừ xa: 10',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      cardWidth,
                      'Thông báo',
                      '5',
                      'Cập nhật lịch làm việc\nCông việc cần hoàn thành',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const EmployeeManagementScreen(),
                              ),
                            );
                          },
                          child: const Text('Quản lý nhân sự'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('Đi đến Quản lý công việc');
                          },
                          child: const Text('Quản lý công việc'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print('Đi đến Quản lý nhân sự');
                          },
                          child: const Text('Quản lý nhân sự'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('Đi đến Quản lý công việc');
                          },
                          child: const Text('Quản lý công việc'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(double width, String title, String value, String details) {
    return SizedBox(
      width: width,
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              // Bọc Column trong SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    details,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
