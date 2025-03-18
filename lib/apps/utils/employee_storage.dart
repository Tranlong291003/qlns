import 'package:shared_preferences/shared_preferences.dart';
import 'package:qlns/models/employee.dart';

class EmployeeStorage {
  static const String _key = 'employees';

  // Lưu nhân viên vào SharedPreferences
  static Future<void> saveEmployees(List<Employee> employees) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employeeList =
        employees.map((e) {
          return '${e.id},${e.fullName},${e.phone},${e.email},${e.contractType},${e.positions.join(",")},${e.createdAt.toIso8601String()},${e.updatedAt.toIso8601String()}';
        }).toList();
    await prefs.setStringList(_key, employeeList);
  }

  // Tải nhân viên từ SharedPreferences
  static Future<List<Employee>> loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employeeList = prefs.getStringList(_key) ?? [];
    return employeeList.map((e) {
      List<String> fields = e.split(',');
      return Employee(
        id: int.parse(fields[0]),
        fullName: fields[1],
        phone: fields[2],
        email: fields[3],
        contractType: fields[4],
        positions: fields[5].split(','),
        createdAt: DateTime.parse(fields[6]),
        updatedAt: DateTime.parse(fields[7]),
      );
    }).toList();
  }
}
