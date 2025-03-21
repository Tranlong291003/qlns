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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: const Text(
                  'Thêm nhân sự mới',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(_fullNameController, 'Họ và tên'),
              const SizedBox(height: 15),
              _buildTextField(_phoneController, 'Số điện thoại'),
              const SizedBox(height: 15),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 15),
              _buildDropdown(),
              const SizedBox(height: 15),
              const Text(
                'Chọn vị trí:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 5),
              _buildPositionSelection(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Màu nền nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 50),
                ),
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
                child: const Text(
                  'Lưu nhân viên',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 18,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Loại hợp đồng',
        labelStyle: TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      value: _contractType,
      onChanged: (value) => setState(() => _contractType = value!),
      items:
          ['Full-time', 'Part-time', 'TTS']
              .map(
                (type) =>
                    DropdownMenuItem<String>(value: type, child: Text(type)),
              )
              .toList(),
    );
  }

  // Phần chọn vị trí mới sử dụng Wrap với Checkbox
  Widget _buildPositionSelection() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
          _availablePositions.map((position) {
            return FilterChip(
              label: Text(position),
              selected: _positions.contains(position),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _positions.add(position);
                  } else {
                    _positions.remove(position);
                  }
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.blueAccent,
              labelStyle: TextStyle(
                color:
                    _positions.contains(position) ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
    );
  }
}
