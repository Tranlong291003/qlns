import 'package:flutter/material.dart';
import 'package:qlns/models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, // Nền trong suốt cho Dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ), // Viền bo tròn cho Dialog
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Center(
                child: Text(
                  'Thông tin công việc',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Card cho từng mục thông tin
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Tên công việc:', task.taskName),
                      const SizedBox(height: 10),
                      _buildInfoRow('Mô tả công việc:', task.description),
                      const SizedBox(height: 10),
                      _buildInfoRow('Trạng thái:', task.status),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                        'Ngày bắt đầu:',
                        _formatDate(task.startDate),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                        'Ngày kết thúc:',
                        _formatDate(task.endDate),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoRow(
                        'Nhân viên thực hiện:',
                        task.assignedTo.join(', '),
                      ),
                    ],
                  ),
                ),
              ),
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
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
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
