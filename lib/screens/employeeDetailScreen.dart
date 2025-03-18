import 'package:flutter/material.dart';
import 'package:qlns/models/employee.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết nhân sự'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Họ và tên:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    employee.fullName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildDetailRow('Email:', employee.email),
                  _buildDetailRow('Số điện thoại:', employee.phone),
                  _buildDetailRow('Loại hợp đồng:', employee.contractType),
                  _buildDetailRow('Vị trí:', employee.positions.join(', ')),
                  const SizedBox(height: 20),
                  _buildDetailRow('Ngày tạo:', _formatDate(employee.createdAt)),
                  _buildDetailRow(
                    'Ngày cập nhật:',
                    _formatDate(employee.updatedAt),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget để hiển thị các thông tin dạng row
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(
            '$title ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm định dạng ngày
  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
