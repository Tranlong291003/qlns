import 'package:flutter/material.dart';
import 'package:qlns/models/employee.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      child: Dialog(
        backgroundColor: Colors.white, // Màu nền cho Dialog
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Viền bo tròn cho Dialog
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Thêm padding cho dialog
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Center(
                child: Text(
                  'Thông tin nhân viên',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Card cho từng mục thông tin
              _buildInfoRow('Họ và tên:', employee.fullName),
              const SizedBox(height: 10),
              _buildInfoRow('Email:', employee.email),
              _buildInfoRow('Số điện thoại:', employee.phone),
              _buildInfoRow('Loại hợp đồng:', employee.contractType),
              _buildInfoRow('Vị trí:', employee.positions.join(', ')),
              const SizedBox(height: 20),
              _buildInfoRow('Ngày tạo:', _formatDate(employee.createdAt)),
              _buildInfoRow('Ngày cập nhật:', _formatDate(employee.updatedAt)),

              const SizedBox(height: 20),
              // Nút Đóng Dialog
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Đóng dialog khi nhấn vào nút
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Nền màu xanh
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 30,
                    ),
                  ),
                  child: const Text(
                    'Đóng',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to format the date
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}'; // Chỉ lấy ngày, tháng, năm
  }

  // Helper function to build info rows
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
