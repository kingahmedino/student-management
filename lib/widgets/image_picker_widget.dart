import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;
  final String? currentImageUrl;
  final File? initialImage;

  const ProfileImagePicker({
    super.key,
    required this.onImageSelected,
    this.currentImageUrl,
    this.initialImage,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _selectedImage;
  final _imagePicker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  @override
  void didUpdateWidget(ProfileImagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected image when initialImage changes
    if (widget.initialImage != oldWidget.initialImage) {
      setState(() {
        _selectedImage = widget.initialImage;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);

      final pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        widget.onImageSelected(_selectedImage);
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () => _showImageSourceDialog(context),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: _buildProfileImage(theme),
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => _showImageSourceDialog(context),
          icon: const Icon(Icons.add_a_photo_outlined),
          label: Text(_selectedImage == null ? 'Add Photo' : 'Change Photo'),
        ),
      ],
    );
  }

  Widget _buildProfileImage(ThemeData theme) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: theme.colorScheme.primary,
        ),
      );
    }

    if (_selectedImage != null) {
      return ClipOval(
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: 120,
          height: 120,
        ),
      );
    }

    if (widget.currentImageUrl != null) {
      return ClipOval(
        child: Image.network(
          widget.currentImageUrl!,
          fit: BoxFit.cover,
          width: 120,
          height: 120,
          loadingBuilder: (context, child, loading) {
            if (loading == null) return child;
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.person_outline,
              size: 40,
              color: theme.colorScheme.primary,
            );
          },
        ),
      );
    }

    return Icon(
      Icons.person_outline,
      size: 40,
      color: theme.colorScheme.primary,
    );
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    final theme = Theme.of(context);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Select Image Source',
          style: theme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
