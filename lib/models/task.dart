class Task {
  int id;
  String taskName;
  List<String> assignedTo; // Danh sách nhân viên được giao công việc
  DateTime startDate;
  DateTime endDate;
  String status; // Trạng thái công việc (Đang làm, Đã hoàn thành, Chưa bắt đầu)
  String description; // Mô tả công việc

  Task({
    required this.id,
    required this.taskName,
    required this.assignedTo,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.description,
  });

  // Hàm chuyển đổi sang chuỗi lưu trữ trong SharedPreferences
  @override
  String toString() {
    return '$id,$taskName,${assignedTo.join(",")},$startDate,$endDate,$status,$description';
  }

  // Hàm chuyển từ chuỗi lưu trữ trong SharedPreferences thành Task
  static Task fromString(String str) {
    final fields = str.split(',');
    return Task(
      id: int.parse(fields[0]),
      taskName: fields[1],
      assignedTo: fields[2].split(','),
      startDate: DateTime.parse(fields[3]),
      endDate: DateTime.parse(fields[4]),
      status: fields[5],
      description: fields[6],
    );
  }
}
