import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/models/students.dart';

class StudentController {
  static const String _prefsKey = 'students';

  Future<List<Student>> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final studentsJson = prefs.getStringList(_prefsKey) ?? [];
    return studentsJson
        .map((json) => Student.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> addStudent(Student student) async {
    final prefs = await SharedPreferences.getInstance();
    final students = await getStudents();
    students.add(student);
    await prefs.setStringList(
      _prefsKey,
      students.map((s) => jsonEncode(s.toJson())).toList(),
    );
  }

  Future<void> deleteStudent(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final students = await getStudents();
    students.removeWhere((s) => s.id == id);
    await prefs.setStringList(
      _prefsKey,
      students.map((s) => jsonEncode(s.toJson())).toList(),
    );
  }
}
