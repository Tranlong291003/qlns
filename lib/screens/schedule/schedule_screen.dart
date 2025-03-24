import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkScheduleScreen(),
    );
  }
}

class WorkScheduleScreen extends StatefulWidget {
  const WorkScheduleScreen({super.key});

  @override
  _WorkScheduleScreenState createState() => _WorkScheduleScreenState();
}

class _WorkScheduleScreenState extends State<WorkScheduleScreen> {
  List<Map<String, String>> schedules = [
    {
      'name': 'Nguyen Van A',
      'date': '2025-03-25',
      'shift': 'Sáng',
      'status': 'Sẵn sàng',
    },
    {
      'name': 'Tran Van B',
      'date': '2025-03-26',
      'shift': 'Chiều',
      'status': 'Chưa sẵn sàng',
    },
  ];

  List<String> employees = [
    'Nguyen Van A',
    'Tran Van B',
    'Le Thi C',
    'Pham Van D',
  ];

  void _addSchedule(String name, String date, String shift, String status) {
    setState(() {
      schedules.add({
        'name': name,
        'date': date,
        'shift': shift,
        'status': status,
      });
    });
  }

  void _editSchedule(
    int index,
    String name,
    String date,
    String shift,
    String status,
  ) {
    setState(() {
      schedules[index] = {
        'name': name,
        'date': date,
        'shift': shift,
        'status': status,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý lịch làm việc')),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(schedules[index]['name']!),
            subtitle: Text(
              '${schedules[index]['date']} - ${schedules[index]['shift']}',
            ),
            trailing: Text(schedules[index]['status']!),
            onTap: () {
              _showEditDialog(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    _showScheduleDialog(isEditing: false);
  }

  void _showEditDialog(int index) {
    _showScheduleDialog(isEditing: true, index: index);
  }

  void _showScheduleDialog({required bool isEditing, int? index}) {
    String name = isEditing ? schedules[index!]['name']! : employees.first;
    String date = isEditing ? schedules[index!]['date']! : '';
    String shift = isEditing ? schedules[index!]['shift']! : '';
    String status = isEditing ? schedules[index!]['status']! : '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            isEditing ? 'Chỉnh sửa lịch làm việc' : 'Thêm lịch làm việc',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: name,
                decoration: InputDecoration(labelText: 'Tên nhân viên'),
                items:
                    employees.map((employee) {
                      return DropdownMenuItem(
                        value: employee,
                        child: Text(employee),
                      );
                    }).toList(),
                onChanged: (value) => name = value!,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Ngày làm việc'),
                onChanged: (value) => date = value,
                controller: TextEditingController(text: date),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Ca làm việc'),
                onChanged: (value) => shift = value,
                controller: TextEditingController(text: shift),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Trạng thái'),
                onChanged: (value) => status = value,
                controller: TextEditingController(text: status),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  _editSchedule(index!, name, date, shift, status);
                } else {
                  _addSchedule(name, date, shift, status);
                }
                Navigator.pop(context);
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }
}
