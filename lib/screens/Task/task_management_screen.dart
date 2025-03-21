import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/custom_app_bar.dart';
import 'package:qlns/apps/utils/search.dart';
import 'package:qlns/models/task.dart';
import 'package:qlns/apps/utils/task_storage.dart';
import 'package:qlns/screens/Task/add_task_screen.dart';
import 'package:qlns/screens/Task/edit_task_screen%20.dart';
import 'package:qlns/screens/Task/task_detail_screen.dart';

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  List<Task> tasks = [];
  List<Task> filteredTasks = []; // Danh sách công việc đã được lọc
  final TextEditingController _searchController =
      TextEditingController(); // Controller tìm kiếm

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks from SharedPreferences when the screen is created
    _searchController.addListener(
      _filterTasks,
    ); // Lắng nghe sự thay đổi trong ô tìm kiếm
  }

  // Load task list from SharedPreferences
  _loadTasks() async {
    final loadedTasks = await TaskStorage.loadTasks();
    setState(() {
      tasks = loadedTasks;
      filteredTasks = tasks; // Mặc định hiển thị tất cả công việc
    });
  }

  // Lọc công việc theo từ khóa tìm kiếm
  _filterTasks() {
    setState(() {
      filteredTasks =
          tasks
              .where(
                (task) =>
                    task.taskName.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ||
                    task.description.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
              ) // Lọc theo tên và mô tả công việc
              .toList();
    });
  }

  // Add a new task to the list
  _addTask(Task newTask) {
    setState(() {
      tasks.add(newTask); // Immediately update the task list
      filteredTasks = tasks; // Cập nhật lại danh sách lọc
    });
    TaskStorage.saveTasks(tasks); // Save updated tasks to SharedPreferences
  }

  // Update an existing task
  _updateTask(Task updatedTask) {
    setState(() {
      int index = tasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        tasks[index] = updatedTask; // Update the task in the list
      }
      filteredTasks = tasks; // Cập nhật lại danh sách lọc
    });
    TaskStorage.saveTasks(tasks); // Save updated tasks to SharedPreferences
  }

  // Delete a task from the list
  _deleteTask(int taskId) {
    setState(() {
      tasks.removeWhere((task) => task.id == taskId);
      filteredTasks = tasks; // Cập nhật lại danh sách lọc
    });
    TaskStorage.saveTasks(
      tasks,
    ); // Save the updated task list to SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Quản lý công việc'),
      body: Column(
        children: [
          SizedBox(height: 10),
          // Replace with your custom search widget
          search(context, (searchText) {
            _searchController.text =
                searchText; // Sync the search text with the controller
            _filterTasks(); // Trigger filtering
          }),
          // Danh sách công việc
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length, // Sử dụng danh sách đã được lọc
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      task.taskName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Deadline: ${task.endDate.toLocal()}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon chỉnh sửa
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Mở popup để chỉnh sửa công việc
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditTaskScreen(
                                  task: task,
                                  onSave: _updateTask, // Chức năng chỉnh sửa
                                );
                              },
                            );
                          },
                        ),
                        // Icon xóa công việc
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed:
                              () => _deleteTask(task.id), // Xóa công việc
                        ),
                      ],
                    ),
                    onTap: () {
                      // Hiển thị TaskDetailScreen dưới dạng popup
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TaskDetailScreen(
                            task: task,
                          ); // Hiển thị chi tiết công việc dưới dạng popup
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show the Add Task dialog
          final newTask = await showDialog<Task>(
            context: context,
            builder: (BuildContext context) {
              return AddTaskScreen(); // Show AddTaskScreen as a dialog
            },
          );

          if (newTask != null) {
            _addTask(
              newTask,
            ); // Nếu công việc mới được thêm, thêm vào danh sách và lưu
          }
        },
        backgroundColor: Colors.blueAccent, // Nền màu xanh đẹp mắt
        elevation: 8, // Bóng đổ nhẹ nhàng, tạo hiệu ứng nổi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ), // Bo tròn nút với bán kính lớn hơn
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ], // Tạo hiệu ứng gradient mượt mà
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              30,
            ), // Bo tròn với cùng kích thước như shape
          ),
          child: Icon(
            Icons.add,
            size: 40, // Kích thước biểu tượng lớn hơn, dễ nhận diện
            color: Colors.white, // Màu sắc biểu tượng nổi bật
          ),
        ),
      ),
    );
  }
}
