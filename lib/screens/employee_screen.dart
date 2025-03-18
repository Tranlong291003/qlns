import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/customAppBar.dart';
import 'package:qlns/apps/utils/search.dart';
import 'package:qlns/widgets/Employee/add_employee_form.dart';
import 'package:qlns/widgets/Employee/employee_list.dart';
import 'package:qlns/apps/utils/employee_storage.dart';
import 'package:qlns/models/employee.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  List<Employee> employees = [];
  List<Employee> filteredEmployees = []; // Lưu trữ danh sách đã lọc
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadEmployees(); // Tải dữ liệu nhân viên khi màn hình khởi tạo
  }

  Future<void> _loadEmployees() async {
    final loadedEmployees = await EmployeeStorage.loadEmployees();
    setState(() {
      employees = loadedEmployees;
      filteredEmployees = employees; // Ban đầu, hiển thị tất cả nhân viên
    });
  }

  // Hàm lọc nhân viên theo tên và vị trí
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

  // Xóa nhân viên
  void _deleteEmployee(int id) async {
    setState(() {
      employees.removeWhere((employee) => employee.id == id);
      filteredEmployees.removeWhere(
        (employee) => employee.id == id,
      ); // Cập nhật danh sách đã lọc
    });
    await EmployeeStorage.saveEmployees(employees); // Lưu lại sau khi xóa
  }

  // Mở Dialog để thêm nhân viên
  void _addEmployee() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEmployeeForm(
          onSave: (newEmployee) async {
            setState(() {
              employees.add(newEmployee);
              filteredEmployees.add(newEmployee); // Cập nhật danh sách đã lọc
            });
            await EmployeeStorage.saveEmployees(
              employees,
            ); // Lưu danh sách sau khi thêm
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Hàm chỉnh sửa nhân viên
  void _editEmployee(Employee updatedEmployee) async {
    setState(() {
      // Cập nhật nhân viên trong danh sách
      final index = employees.indexWhere(
        (employee) => employee.id == updatedEmployee.id,
      );
      if (index != -1) {
        employees[index] = updatedEmployee;
        filteredEmployees[index] = updatedEmployee; // Cập nhật danh sách đã lọc
      }
    });
    await EmployeeStorage.saveEmployees(employees); // Lưu lại sau khi chỉnh sửa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Quản lý nhân sự'),
      body: Column(
        children: [
          const SizedBox(height: 10),
          search(context, _onSearchChanged), // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: EmployeeList(
              employees: filteredEmployees, // Hiển thị danh sách đã lọc
              onDelete: _deleteEmployee,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEmployee,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
