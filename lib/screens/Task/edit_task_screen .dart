import 'package:flutter/material.dart';
import 'package:qlns/models/task.dart';
import 'package:qlns/models/employee.dart';
import 'package:qlns/apps/utils/employee_storage.dart'; // Để lấy danh sách nhân viên

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onSave;

  const EditTaskScreen({super.key, required this.task, required this.onSave});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _taskNameController;
  late TextEditingController _descriptionController;
  late DateTime _startDate;
  late DateTime _endDate;
  late String _status;
  List<Employee> _employees = [];
  Employee? _selectedEmployee;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController(text: widget.task.taskName);
    _descriptionController = TextEditingController(
      text: widget.task.description,
    );
    _startDate = widget.task.startDate;
    _endDate = widget.task.endDate;
    _status = widget.task.status;
    _loadEmployees();
  }

  // Tải danh sách nhân viên
  _loadEmployees() async {
    final loadedEmployees = await EmployeeStorage.loadEmployees();
    setState(() {
      _employees = loadedEmployees;
      if (_employees.isNotEmpty) {
        _selectedEmployee = _employees.firstWhere(
          (emp) => emp.fullName == widget.task.assignedTo.first,
          orElse: () => _employees[0],
        ); // Đặt nhân viên hiện tại nếu có
      }
    });
  }

  // Hàm định dạng ngày tháng
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}'; // Định dạng ngày/tháng/năm
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, // Nền trong suốt cho Dialog
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
                  'Chỉnh sửa công việc',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
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
                    borderSide: BorderSide(color: Colors.black),
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Ngày bắt đầu
              Text('Ngày bắt đầu: ${_formatDate(_startDate)}'),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? newStartDate = await showDatePicker(
                      context: context,
                      initialDate: _startDate,
                      firstDate: DateTime(2020),
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
              Text('Ngày kết thúc: ${_formatDate(_endDate)}'),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? newEndDate = await showDatePicker(
                      context: context,
                      initialDate: _endDate,
                      firstDate: DateTime(2020),
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
              Text('Trạng thái:'),
              // Trạng thái
              DropdownButton<String>(
                value: _status,
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                items:
                    ['Chưa bắt đầu', 'Đang làm', 'Đã hoàn thành']
                        .map(
                          (status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
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
              if (_employees.isNotEmpty)
                DropdownButton<Employee>(
                  value: _selectedEmployee,
                  onChanged: (Employee? newValue) {
                    setState(() {
                      _selectedEmployee = newValue;
                      if (_selectedEmployee != null) {
                        // Cập nhật danh sách nhân viên thực hiện công việc
                      }
                    });
                  },
                  items:
                      _employees.map((Employee employee) {
                        return DropdownMenuItem<Employee>(
                          value: employee,
                          child: Text(employee.fullName),
                        );
                      }).toList(),
                  isExpanded: true,
                ),
              const SizedBox(height: 20),

              // Nút lưu thay đổi
              Container(
                alignment: Alignment.centerRight, // Căn trái
                child: ElevatedButton(
                  onPressed: () {
                    final updatedTask = Task(
                      id: widget.task.id,
                      taskName: _taskNameController.text,
                      description: _descriptionController.text,
                      assignedTo:
                          _selectedEmployee != null
                              ? [_selectedEmployee!.fullName]
                              : widget
                                  .task
                                  .assignedTo, // Cập nhật nhân viên thực hiện
                      startDate: _startDate,
                      endDate: _endDate,
                      status: _status,
                    );
                    widget.onSave(updatedTask); // Lưu thay đổi
                    Navigator.pop(context); // Đóng dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Nền màu xanh lá
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  child: const Text(
                    'Lưu thay đổi',
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
