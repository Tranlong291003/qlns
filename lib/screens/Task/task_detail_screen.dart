import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/box_details.dart';
import 'package:qlns/models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

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
              // Icon và tiêu đề
              const Icon(
                Icons.task_alt_rounded,
                size: 40,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 10),
              const Text(
                'Chi tiết công việc',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Danh sách thông tin công việc
              Expanded(
                child: ListView(
                  children: [
                    buildInfoTile(Icons.title, 'Tên công việc', task.taskName),
                    buildInfoTile(Icons.description, 'Mô tả', task.description),
                    buildInfoTile(
                      Icons.info_outline,
                      'Trạng thái',
                      task.status,
                    ),
                    buildInfoTile(
                      Icons.event,
                      'Ngày kết thúc',
                      _formatDate(task.endDate),
                    ),
                    buildInfoTile(
                      Icons.event,
                      'Ngày kết thúc',
                      _formatDate(task.endDate),
                    ),
                    buildInfoTile(
                      Icons.people,
                      'Nhân viên thực hiện',
                      task.assignedTo.join(', '),
                    ),
                  ],
                ),
              ),
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
