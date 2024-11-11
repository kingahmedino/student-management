import 'package:flutter/material.dart';
import 'package:student_management/models/students.dart';
import 'package:student_management/utils/functions.dart';

class AddStudentForm extends StatefulWidget {
  final Function(Student) onStudentAdded;

  const AddStudentForm({
    super.key,
    required this.onStudentAdded,
  });

  @override
  State<AddStudentForm> createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _enrollmentStatus = 'Enrolled';
  String? _profilePhotoPath;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _animation,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                style: theme.textTheme.bodyLarge,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                style: theme.textTheme.bodyLarge,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateEmail,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _enrollmentStatus,
                decoration: const InputDecoration(
                  labelText: 'Enrollment Status',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                style: theme.textTheme.bodyLarge,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: ['Enrolled', 'Graduated', 'Alumni']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _enrollmentStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final student = Student(
        id: DateTime.now().toString(),
        name: _nameController.text,
        email: _emailController.text,
        enrollmentStatus: _enrollmentStatus,
        profilePhotoPath: _profilePhotoPath,
      );
      widget.onStudentAdded(student);
      _nameController.clear();
      _emailController.clear();
      setState(() {
        _enrollmentStatus = 'Enrolled';
        _profilePhotoPath = null;
      });
    }
  }
}
