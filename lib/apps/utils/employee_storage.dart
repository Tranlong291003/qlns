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

      // Kiểm tra và chuyển đổi an toàn cho DateTime
      DateTime? createdAt = _parseDate(fields[6]);
      DateTime? updatedAt = _parseDate(fields[7]);

      return Employee(
        id: int.parse(fields[0]),
        fullName: fields[1],
        phone: fields[2],
        email: fields[3],
        contractType: fields[4],
        positions: fields[5].split(','),
        createdAt:
            createdAt ?? DateTime.now(), // Nếu không hợp lệ, dùng ngày hiện tại
        updatedAt:
            updatedAt ?? DateTime.now(), // Nếu không hợp lệ, dùng ngày hiện tại
      );
    }).toList();
  }

  // Hàm giúp kiểm tra và chuyển đổi chuỗi thành DateTime hợp lệ
  static DateTime? _parseDate(String dateString) {
    try {
      return DateTime.tryParse(dateString);
    } catch (e) {
      print('Lỗi khi chuyển đổi ngày: $e');
      return null; // Nếu không hợp lệ, trả về null
    }
  }
}
