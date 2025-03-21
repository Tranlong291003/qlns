import 'package:shared_preferences/shared_preferences.dart';
import 'package:qlns/models/employee.dart';

class EmployeeStorage {
  static const String _key = 'employees';

  static Future<void> saveEmployees(List<Employee> employees) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employeeList =
        employees.map((e) {
          return '${e.id},${e.fullName},${e.phone},${e.email},${e.contractType},${e.positions.join(",")},${e.createdAt.toIso8601String()},${e.updatedAt.toIso8601String()}';
        }).toList();
    await prefs.setStringList(_key, employeeList);
  }

  static Future<List<Employee>> loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employeeList = prefs.getStringList(_key) ?? [];

    return employeeList.map((e) {
      List<String> fields = e.split(',');

      DateTime? createdAt = _parseDate(fields[6]);
      DateTime? updatedAt = _parseDate(fields[7]);

      return Employee(
        id:
            int.tryParse(fields[0]) ??
            0, // Nếu không thể chuyển thành số, sử dụng 0
        fullName: fields[1],
        phone: fields[2],
        email: fields[3],
        contractType: fields[4],
        positions: fields[5].split(','),
        createdAt: createdAt ?? DateTime.now(),
        updatedAt: updatedAt ?? DateTime.now(),
      );
    }).toList();
  }

  static DateTime? _parseDate(String dateString) {
    try {
      return DateTime.tryParse(dateString);
    } catch (e) {
      print('Lỗi khi chuyển đổi ngày: $e');
      return null;
    }
  }
}
