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
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  String _contractType = 'Full-time';
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: const Text(
                'Chỉnh sửa nhân viên',
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            _buildPositionSelection(),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                final updatedEmployee = Employee(
                  id: widget.employee.id,
                  fullName: _fullNameController.text,
                  phone: _phoneController.text,
                  email: _emailController.text,
                  contractType: _contractType,
                  positions: _positions,
                  createdAt: widget.employee.createdAt,
                  updatedAt: DateTime.now(),
                );
                widget.onSave(updatedEmployee);
              },
              child: const Text(
                'Lưu nhân viên',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextFormField cho các trường nhập liệu
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

  // Dropdown cho loại hợp đồng
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

  // Phần chọn vị trí sử dụng FilterChip
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
