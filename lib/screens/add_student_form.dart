import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_management/models/students.dart';
import 'package:student_management/utils/functions.dart';
import 'package:student_management/services/image_upload_service.dart';
import 'package:student_management/widgets/image_picker_widget.dart';
import 'package:student_management/widgets/upload_progress_indicator.dart';

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
  late AnimationController _animationController;
  late Animation<double> _animation;

  File? _profileImage;
  final _imageUploadService = ImageUploadService();
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String _uploadStatus = '';

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
              ProfileImagePicker(
                onImageSelected: (file) {
                  setState(() => _profileImage = file);
                },
                initialImage: _profileImage,
                currentImageUrl: null,
              ),
              if (_isUploading) ...[
                const SizedBox(height: 16),
                UploadProgressIndicator(
                  progress: _uploadProgress,
                  message: _uploadStatus,
                ),
              ],
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                style: theme.textTheme.bodyLarge,
                validator: Validators.name,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                style: theme.textTheme.bodyLarge,
                validator: Validators.email,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _enrollmentStatus,
                decoration: const InputDecoration(
                  labelText: 'Enrollment Status',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                style: theme.textTheme.bodyLarge,
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
                onPressed: _isUploading ? null : _submitForm,
                child: Text(_isUploading ? 'Uploading...' : 'Add Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isUploading = true;
        _uploadProgress = 0.0;
        _uploadStatus = 'Preparing upload...';
      });

      try {
        String? profilePhotoUrl;

        if (_profileImage != null) {
          setState(() => _uploadStatus = 'Uploading image...');

          profilePhotoUrl = await _imageUploadService.uploadImage(
            _profileImage!,
            onProgress: (progress) {
              setState(() {
                _uploadProgress = progress.progress;
                _uploadStatus =
                    'Uploading: ${(progress.progress * 100).toInt()}%\n'
                    '${_formatBytes(progress.bytesUploaded)} of ${_formatBytes(progress.totalBytes)}';
              });
            },
          );

          if (profilePhotoUrl == null) {
            throw Exception('Failed to upload image');
          }
        }

        setState(() => _uploadStatus = 'Creating student profile...');

        final student = Student(
          id: DateTime.now().toString(),
          name: _nameController.text,
          email: _emailController.text,
          enrollmentStatus: _enrollmentStatus,
          profilePhotoUrl: profilePhotoUrl,
        );

        widget.onStudentAdded(student);
        _resetForm();

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Student added successfully'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        setState(() {
          _isUploading = false;
          _uploadProgress = 0.0;
          _uploadStatus = '';
        });
      }
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    setState(() {
      _enrollmentStatus = 'Enrolled';
      _profileImage = null;
      _uploadProgress = 0.0;
      _uploadStatus = '';
      _isUploading = false;
    });
  }
}
