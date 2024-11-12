# Student Management System

A Flutter application for managing student profiles, built with clean architecture and modern Flutter practices.

## Features

- 👥 Student Profile Management

  - Create student profiles with personal information
  - View list of all students
  - Delete student profiles
  - Supports profile photo uploads

- 📱 Modern UI/UX

  - Material Design 3
  - Responsive layout
  - Clean and intuitive interface
  - Smooth animations and transitions
  - Loading states and error handling

- 🖼️ Image Management

  - Upload profile photos using ImgHippo API
  - Image upload progress tracking
  - Fallback avatars with initials
  - Cached network images for better performance

- 💾 Data Persistence
  - Local storage using SharedPreferences
  - Efficient data management
  - Data validation

## Setup

### Prerequisites

- Flutter (Latest stable version)
- Dart SDK
- VS Code or Android Studio
- Image upload API key from ImgHippo (You can find an API key in my response to the Google form)

### Environment Setup

1. Create a `.env` file in the root directory with the following content:

```bash
IMG_HIPPO_API_URL=https://api.imghippo.com/v1/upload
IMG_HIPPO_API_KEY=your_api_key_here
```

2. Add `.env` to your `.gitignore` file to keep your API key secure.

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/student-management.git
cd student-management
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run --dart-define-from-file .env
```

### VS Code Configuration

Add the following to your `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "build",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--dart-define-from-file", ".env"]
    }
  ]
}
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  image_picker: ^1.0.4
  cached_network_image: ^3.3.0
  shared_preferences: ^2.2.0
```

## Project Structure

```
lib/
  ├── config/
  │   └── env.dart
  ├── models/
  │   └── student.dart
  ├── services/
  │   └── image_upload_service.dart
  ├── widgets/
  │   ├── student_list_view.dart
  │   ├── add_student_form.dart
  │   └── profile_image_picker.dart
  ├── screens/
  │   └── home_page.dart
  └── main.dart
```

## Features in Detail

### Student Profile Creation

- Name validation (letters and spaces only)
- Email validation
- Enrollment status selection
- Profile photo upload with progress tracking

### Profile Photos

- Support for camera and gallery image selection
- Image compression before upload
- Loading states during upload
- Fallback to initials when no photo is available

### List View Features

- Swipe to delete
- Status indicators
- Clean, card-based design
- Optimized performance with ListView.builder

## Known Limitations

1. Image Upload

   - Maximum file size: 50MB
   - Supported formats: JPG, PNG
   - No image editing capabilities
   - Internet connection required for photo uploads

2. General
   - No offline mode for image uploads
   - No student profile editing after creation
   - No batch operations (e.g., delete multiple students)
   - No search functionality
   - No sorting or filtering options

## Testing

Run the tests using:

```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
