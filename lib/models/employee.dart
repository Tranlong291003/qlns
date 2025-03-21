class Employee {
  final int id;
  final String fullName;
  final String phone;
  final String email;
  final String contractType;
  final List<String> positions;
  final DateTime createdAt;
  final DateTime updatedAt;

  Employee({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.contractType,
    required this.positions,
    required this.createdAt,
    required this.updatedAt,
  });

  // Chuyển đối tượng thành chuỗi để lưu trữ
  @override
  String toString() {
    return '$id,$fullName,$phone,$email,$contractType,${positions.join(",")},${createdAt.toIso8601String()},${updatedAt.toIso8601String()}';
  }

  // Phương thức chuyển từ chuỗi thành đối tượng
  static Employee fromString(String str) {
    final fields = str.split(',');
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
  }
}
