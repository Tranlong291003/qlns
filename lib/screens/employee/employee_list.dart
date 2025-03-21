import 'package:flutter/material.dart';
import 'package:qlns/models/employee.dart';
import 'package:qlns/screens/employee/EditEmployeeScreen.dart';
import 'package:qlns/screens/employee/employeeDetailScreen.dart';

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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
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
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditEmployeeScreen(
                                      employee: employee,
                                      onSave: (updatedEmployee) {
                                        setState(() {
                                          int index = widget.employees
                                              .indexWhere(
                                                (e) =>
                                                    e.id == updatedEmployee.id,
                                              );
                                          if (index != -1)
                                            widget.employees[index] =
                                                updatedEmployee;
                                        });
                                      },
                                    ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => widget.onDelete(employee.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  EmployeeDetailScreen(employee: employee),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
