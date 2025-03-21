import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qlns/models/employee.dart';

class AddEmployeeForm extends StatefulWidget {
  final Function(Employee) onSave;

  const AddEmployeeForm({super.key, required this.onSave});

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _contractType = 'Full-time';
  final List<String> _positions = [];
  final List<String> _availablePositions = [
    'BA',
    'FE',
    'BE',
    'Tester',
    'DevOps',
  ];
  int _nextId = 1;

  @override
  void initState() {
    super.initState();
    _loadNextId();
  }

  _loadNextId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nextId = prefs.getInt('nextId') ?? 1;
    });
  }

  _saveNextId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('nextId', _nextId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: const Text(
                  'Thêm nhân sự mới',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
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
                onChanged: (value) => setState(() => _contractType = value!),
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
              const Text(
                'Chọn vị trí:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ..._availablePositions.map((position) {
                return CheckboxListTile(
                  title: Text(position),
                  value: _positions.contains(position),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected == true) {
                        if (!_positions.contains(position))
                          _positions.add(position);
                      } else {
                        _positions.remove(position);
                      }
                    });
                  },
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newEmployee = Employee(
                    id: _nextId++,
                    fullName: _fullNameController.text,
                    phone: _phoneController.text,
                    email: _emailController.text,
                    contractType: _contractType,
                    positions: _positions,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  widget.onSave(newEmployee);
                  _saveNextId();
                },
                child: const Center(child: Text('Lưu nhân viên')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
