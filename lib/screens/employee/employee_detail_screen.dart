import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/box_details.dart';
import 'package:qlns/models/employee.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ảnh đại diện + tên
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  'assets/images/avatar.png',
                ), // ảnh local hoặc thay NetworkImage
              ),
              const SizedBox(height: 10),
              Text(
                employee.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Các dòng thông tin
              Expanded(
                child: ListView(
                  children: [
                    buildInfoTile(Icons.email, 'Email', employee.email),
                    buildInfoTile(Icons.phone, 'Số điện thoại', employee.phone),
                    buildInfoTile(
                      Icons.assignment,
                      'Loại hợp đồng',
                      employee.contractType,
                    ),
                    buildInfoTile(
                      Icons.work_outline,
                      'Vị trí',
                      employee.positions.join(', '),
                    ),
                    buildInfoTile(
                      Icons.calendar_today,
                      'Ngày tạo',
                      _formatDate(employee.createdAt),
                    ),
                    buildInfoTile(
                      Icons.update,
                      'Ngày cập nhật',
                      _formatDate(employee.updatedAt),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Nút Đóng
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  label: const Text('Đóng'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
