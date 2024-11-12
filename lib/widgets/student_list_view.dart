import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:student_management/models/students.dart';

class StudentListView extends StatefulWidget {
  final List<Student> students;
  final Function(String) onDelete;

  const StudentListView({
    super.key,
    required this.students,
    required this.onDelete,
  });

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView>
    with SingleTickerProviderStateMixin {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.students.isEmpty) {
      return FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_outline,
                size: 64,
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No students yet',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap the + button below to add your first student',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: _animation,
      child: ListView.builder(
        itemCount: widget.students.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final student = widget.students[index];
          return _buildStudentCard(context, student);
        },
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, Student student) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildProfileImage(context, student),
        title: Text(
          student.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              student.email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            _buildEnrollmentBadge(context, student.enrollmentStatus),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: theme.colorScheme.error,
          ),
          onPressed: () => _showDeleteConfirmation(context, student),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context, Student student) {
    final theme = Theme.of(context);

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: student.profilePhotoUrl != null
            ? CachedNetworkImage(
                imageUrl: student.profilePhotoUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildLoadingIndicator(theme),
                errorWidget: (context, url, error) =>
                    _buildFallbackAvatar(theme, student),
              )
            : _buildFallbackAvatar(theme, student),
      ),
    );
  }

  Widget _buildLoadingIndicator(ThemeData theme) {
    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar(ThemeData theme, Student student) {
    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: Text(
          student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildEnrollmentBadge(BuildContext context, String status) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, Student student) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Are you sure you want to delete ${student.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDelete(student.id);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
