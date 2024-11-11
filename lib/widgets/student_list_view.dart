import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management/models/students.dart';

class StudentListView extends StatelessWidget {
  final List<Student> students;
  final Function(String) onDelete;

  const StudentListView({
    super.key,
    required this.students,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: student.profilePhotoPath != null
                    ? FileImage(File(student.profilePhotoPath!))
                    : null,
                child: student.profilePhotoPath == null
                    ? Text(student.name[0])
                    : null,
              ),
              title: Text(student.name),
              subtitle: Text('${student.email}\n${student.enrollmentStatus}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(student.id),
              ),
            ),
          ),
        );
      },
    );
  }
}
