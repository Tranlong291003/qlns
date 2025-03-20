import 'package:flutter/material.dart';
import 'package:qlns/models/employee.dart';
import 'package:qlns/screens/employeeDetailScreen.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final Function(int) onDelete;

  const EmployeeList({
    super.key,
    required this.employees,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children:
              employees.map((employee) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 5, // Shadow for Card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
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
                        color: Colors.blueAccent, // Customize the name color
                      ),
                    ),
                    subtitle: Text(
                      'Email: ${employee.email}\nSố điện thoại: ${employee.phone}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Colors
                                .grey[600], // Light grey text for the subtitle
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            // Implement edit action
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => onDelete(employee.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to Employee Detail Screen with custom animation
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
