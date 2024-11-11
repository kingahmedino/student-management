import 'package:flutter/material.dart';
import 'package:student_management/controllers/student_controller.dart';
import 'package:student_management/models/students.dart';
import 'package:student_management/screens/add_student_form.dart';
import 'package:student_management/screens/settings_page.dart';
import 'package:student_management/widgets/student_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Student> _students = [];
  final _studentController = StudentController();

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final students = await _studentController.getStudents();
    setState(() {
      _students.clear();
      _students.addAll(students);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Add Student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return StudentListView(
          students: _students,
          onDelete: _deleteStudent,
        );
      case 1:
        return AddStudentForm(onStudentAdded: _addStudent);
      case 2:
        return const SettingsPage();
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _addStudent(Student student) async {
    await _studentController.addStudent(student);
    await _loadStudents();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student added successfully')),
    );
  }

  Future<void> _deleteStudent(String id) async {
    await _studentController.deleteStudent(id);
    await _loadStudents();
  }
}
