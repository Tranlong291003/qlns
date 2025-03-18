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
}
