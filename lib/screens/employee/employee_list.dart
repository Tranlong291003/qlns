import 'package:flutter/material.dart';
import 'package:qlns/models/employee.dart';
import 'package:qlns/screens/employee/Edit_employee_screen.dart';
import 'package:qlns/screens/employee/employee_detail_screen.dart'; // Import the EmployeeDetailScreen

class EmployeeList extends StatefulWidget {
  final List<Employee> employees;
  final Function(int) onDelete;

  const EmployeeList({
    super.key,
    required this.employees,
    required this.onDelete,
  });

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  // Hàm hiển thị dialog chỉnh sửa
  void showDialogEdit(Employee employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: EditEmployeeScreen(
              employee: employee,
              onSave: (updatedEmployee) {
                setState(() {
                  int index = widget.employees.indexWhere(
                    (e) => e.id == updatedEmployee.id,
                  );
                  if (index != -1) {
                    widget.employees[index] = updatedEmployee;
                  }
                });
                Navigator.pop(
                  context,
                  updatedEmployee,
                ); // Đóng dialog sau khi lưu thay đổi
              },
            ),
          ),
        );
      },
    );
  }

  // Hàm hiển thị dialog chi tiết nhân viên sử dụng EmployeeDetailScreen
  void showDialogDetail(Employee employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmployeeDetailScreen(employee: employee);
      },
    );
  }

  // Hàm định dạng ngày
  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children:
            widget.employees.map((employee) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  title: Text(
                    employee.fullName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  subtitle: Text(
                    'Email: ${employee.email}\nSố điện thoại: ${employee.phone}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nút Sửa
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blueAccent),
                        onPressed: () {
                          // Gọi hàm showDialogEdit khi nhấn nút sửa
                          showDialogEdit(employee);
                        },
                      ),
                      // Nút Xóa
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => widget.onDelete(employee.id),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Gọi hàm showDialogDetail khi nhấn vào dòng nhân viên
                    showDialogDetail(employee);
                  },
                ),
              );
            }).toList(),
      ),
    );
  }
}
