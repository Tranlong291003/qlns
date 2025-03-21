import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/custom_app_bar.dart';
import 'package:qlns/apps/utils/search.dart';

import 'package:qlns/apps/utils/employee_storage.dart';
import 'package:qlns/models/employee.dart';
import 'package:qlns/screens/employee/add_employee_form.dart';
import 'package:qlns/screens/employee/employee_list.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  List<Employee> employees = [];
  List<Employee> filteredEmployees = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final loadedEmployees = await EmployeeStorage.loadEmployees();
    setState(() {
      employees = loadedEmployees;
      filteredEmployees = employees;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
      filteredEmployees =
          employees.where((employee) {
            return employee.fullName.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                employee.positions.any(
                  (position) => position.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
                );
          }).toList();
    });
  }

  void _deleteEmployee(int id) async {
    setState(() {
      employees.removeWhere((employee) => employee.id == id);
      filteredEmployees.removeWhere((employee) => employee.id == id);
    });
    await EmployeeStorage.saveEmployees(employees);
  }

  void _addEmployee() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEmployeeForm(
          onSave: (newEmployee) async {
            // Kiểm tra trùng lặp ID
            bool isDuplicate = employees.any((e) => e.id == newEmployee.id);
            if (isDuplicate) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nhân viên này đã tồn tại!')),
              );
              return;
            }
            setState(() {
              employees.add(newEmployee);
              filteredEmployees = List.from(
                employees,
              ); // Đồng bộ filteredEmployees với employees
            });

            // Lưu danh sách nhân viên vào storage
            await EmployeeStorage.saveEmployees(employees);

            // Đóng dialog sau khi lưu
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Quản lý nhân sự'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            search(context, _onSearchChanged), // Tìm kiếm nhân viên
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: EmployeeList(
                employees: filteredEmployees,
                onDelete: _deleteEmployee,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEmployee,
        backgroundColor: Colors.blueAccent, // Màu nền của nút
        elevation: 8, // Bóng đổ để tạo hiệu ứng nổi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bo tròn cho nút
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ], // Tạo hiệu ứng gradient mượt mà
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              30,
            ), // Bo tròn với cùng kích thước như shape
          ),
          child: Icon(
            Icons.add,
            size: 40, // Kích thước biểu tượng lớn hơn, dễ nhận diện
            color: Colors.white, // Màu sắc biểu tượng nổi bật
          ),
        ),
      ),
    );
  }
}
