import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/task_storage.dart';
import 'package:qlns/models/task.dart';
import 'package:qlns/apps/utils/employee_storage.dart'; // Để lấy danh sách nhân viên
import 'package:qlns/models/employee.dart'; // Để sử dụng model Employee
import 'package:intl/intl.dart'; // Thư viện định dạng ngày tháng

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _startDate =
      DateTime.now(); // Đặt ngày bắt đầu mặc định là ngày hiện tại
  DateTime _endDate =
      DateTime.now(); // Đặt ngày kết thúc mặc định là ngày hiện tại
  String _status = 'Chưa bắt đầu';
  List<String> _assignedTo = []; // Employee list
  List<Employee> _employees = []; // Lưu trữ danh sách nhân viên
  Employee? _selectedEmployee;

  @override
  void initState() {
    super.initState();
    _loadEmployees(); // Tải danh sách nhân viên khi màn hình được khởi tạo
  }

  // Tải danh sách nhân viên từ SharedPreferences
  _loadEmployees() async {
    final loadedEmployees = await EmployeeStorage.loadEmployees();
    setState(() {
      _employees = loadedEmployees;
      if (_employees.isNotEmpty) {
        _selectedEmployee = _employees[0]; // Mặc định chọn nhân viên đầu tiên
      }
    });
  }

  // Hàm định dạng ngày tháng
  String _formatDate(DateTime date) {
    return DateFormat(
      'dd/MM/yyyy',
    ).format(date); // Định dạng chỉ ngày, tháng, năm
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, // Background trong suốt
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Tiêu đề
              Center(
                child: Text(
                  'Thêm công việc mới',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Màu tiêu đề
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Tên công việc
              TextField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  labelText: 'Tên công việc',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ), // Đổi màu viền thành đen
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Mô tả công việc
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Mô tả công việc',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ), // Đổi màu viền thành đen
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Ngày bắt đầu
              Text(
                'Ngày bắt đầu: ${_formatDate(_startDate)}',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: double.infinity, // Chiều ngang đầy đủ
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? newStartDate = await showDatePicker(
                      context: context,
                      initialDate: _startDate,
                      firstDate:
                          DateTime.now(), // Cho phép chọn từ ngày hiện tại trở đi
                      lastDate: DateTime(2101),
                    );
                    if (newStartDate != null && newStartDate != _startDate) {
                      setState(() {
                        _startDate = newStartDate;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100], // Màu xanh nhạt
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Chọn ngày bắt đầu',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Ngày kết thúc
              Text(
                'Ngày kết thúc: ${_formatDate(_endDate)}',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? newEndDate = await showDatePicker(
                      context: context,
                      initialDate: _endDate,
                      firstDate:
                          DateTime.now(), // Cho phép chọn từ ngày hiện tại trở đi
                      lastDate: DateTime(2101),
                    );
                    if (newEndDate != null && newEndDate != _endDate) {
                      setState(() {
                        _endDate = newEndDate;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100], // Màu xanh nhạt
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Chọn ngày kết thúc',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Trạng thái
              Text('Trạng thái:', style: TextStyle(color: Colors.black87)),
              DropdownButton<String>(
                value: _status,
                onChanged: (value) {
                  setState(() {
                    _status = value!; // Cập nhật trạng thái khi người dùng chọn
                  });
                },
                items:
                    ['Chưa bắt đầu', 'Đang làm', 'Đã hoàn thành']
                        .map(
                          (status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                style: TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
              const SizedBox(height: 15),
              // Chọn nhân viên
              Text(
                'Nhân viên thực hiện:',
                style: TextStyle(color: Colors.black87),
              ),
              DropdownButton<Employee>(
                value: _selectedEmployee,
                onChanged: (Employee? newValue) {
                  setState(() {
                    _selectedEmployee =
                        newValue; // Cập nhật nhân viên thực hiện
                    if (_selectedEmployee != null) {
                      _assignedTo = [
                        _selectedEmployee!.fullName,
                      ]; // Lưu tên nhân viên đã chọn
                    }
                  });
                },
                items:
                    _employees.map((Employee employee) {
                      return DropdownMenuItem<Employee>(
                        value: employee,
                        child: Text(
                          employee.fullName,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                style: TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
              const SizedBox(height: 10),
              // Nút lưu công việc
              Container(
                alignment: Alignment.centerRight, // Căn phải
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedEmployee != null) {
                      final newTask = Task(
                        id: DateTime.now().millisecondsSinceEpoch,
                        taskName: _taskNameController.text,
                        assignedTo: _assignedTo,
                        startDate: _startDate,
                        endDate: _endDate,
                        status: _status,
                        description: _descriptionController.text,
                      );

                      // Lưu công việc mới vào danh sách công việc
                      TaskStorage.saveTasks([newTask]);
                      Navigator.pop(
                        context,
                        newTask,
                      ); // Quay lại màn hình trước và trả về công việc mới
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Nền màu xanh lá
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  child: const Text(
                    'Lưu công việc',
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
}
