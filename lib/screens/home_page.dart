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

  // Define screen titles
  final List<String> _screenTitles = ['Students', 'Add Student', 'Settings'];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          _screenTitles[_currentIndex],
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: theme.colorScheme.outline.withOpacity(0.1),
            height: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Students',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_outlined),
              activeIcon: Icon(Icons.person_add),
              label: 'Add Student',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadStudents() async {
    final students = await _studentController.getStudents();
    setState(() {
      _students.clear();
      _students.addAll(students);
    });
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
