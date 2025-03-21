import 'package:flutter/material.dart';
import 'package:qlns/models/employee.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee employee;
  final Function(Employee) onSave;

  const EditEmployeeScreen({
    super.key,
    required this.employee,
    required this.onSave,
  });

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  String? _contractType;
  List<String> _positions = [];
  final List<String> _availablePositions = [
    'BA',
    'FE',
    'BE',
    'Tester',
    'DevOps',
  ];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.employee.fullName);
    _phoneController = TextEditingController(text: widget.employee.phone);
    _emailController = TextEditingController(text: widget.employee.email);
    _contractType = widget.employee.contractType;
    _positions = List.from(widget.employee.positions);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chỉnh sửa nhân viên')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Họ và tên'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Số điện thoại'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Loại hợp đồng'),
              value: _contractType,
              onChanged: (value) => setState(() => _contractType = value),
              items:
                  ['Full-time', 'Part-time', 'TTS']
                      .map(
                        (type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 10),
            const Text('Vị trí:'),
            Column(
              children:
                  _availablePositions.map((position) {
                    return CheckboxListTile(
                      title: Text(position),
                      value: _positions.contains(position),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _positions.add(position);
                          } else {
                            _positions.remove(position);
                          }
                        });
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedEmployee = Employee(
                  id: widget.employee.id,
                  fullName: _fullNameController.text,
                  phone: _phoneController.text,
                  email: _emailController.text,
                  contractType: _contractType!,
                  positions: _positions,
                  createdAt: widget.employee.createdAt,
                  updatedAt: DateTime.now(),
                );
                widget.onSave(updatedEmployee);
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}
