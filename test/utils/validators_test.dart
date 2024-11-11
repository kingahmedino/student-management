import 'package:flutter_test/flutter_test.dart';
import 'package:student_management/utils/functions.dart';

void main() {
  group('Name Validation Tests', () {
    test('should return error message when name is null', () {
      expect(Validators.name(null), 'Please enter a name');
    });

    test('should return error message when name is empty', () {
      expect(Validators.name(''), 'Please enter a name');
    });

    test('should return error message when name is too short', () {
      expect(Validators.name('A'), 'Name must be at least 2 characters');
    });

    test('should return error message when name contains numbers', () {
      expect(Validators.name('John123'),
          'Name can only contain letters and spaces');
    });

    test('should return error message when name contains special characters',
        () {
      expect(Validators.name('John@Doe'),
          'Name can only contain letters and spaces');
    });

    test('should return null for valid single word name', () {
      expect(Validators.name('John'), null);
    });

    test('should return null for valid multiple word name', () {
      expect(Validators.name('John Doe'), null);
    });

    test('should return null for valid name with spaces', () {
      expect(Validators.name('Mary Jane Watson'), null);
    });

    test('should handle leading/trailing spaces correctly', () {
      expect(Validators.name('  John  '), null);
    });

    test('should validate names with accented characters', () {
      expect(Validators.name('José María'),
          'Name can only contain letters and spaces');
    });
  });

  group('Email Validation Tests', () {
    test('should return error message when email is null', () {
      expect(Validators.email(null), 'Please enter an email');
    });

    test('should return error message when email is empty', () {
      expect(Validators.email(''), 'Please enter an email');
    });

    test('should return error message when email has no @', () {
      expect(Validators.email('johndoe.com'),
          'Please enter a valid email address');
    });

    test('should return error message when email has no domain', () {
      expect(Validators.email('john@'), 'Please enter a valid email address');
    });

    test('should return error message when email has invalid TLD', () {
      expect(Validators.email('john@domain.'),
          'Please enter a valid email address');
    });

    test('should return error message when TLD is too short', () {
      expect(Validators.email('john@domain.c'),
          'Please enter a valid email address');
    });

    test('should return error message when email has spaces', () {
      expect(Validators.email('john doe@domain.com'),
          'Please enter a valid email address');
    });

    test('should validate correct simple email', () {
      expect(Validators.email('john@domain.com'), null);
    });

    test('should validate email with numbers', () {
      expect(Validators.email('john123@domain.com'), null);
    });

    test('should validate email with dots in local part', () {
      expect(Validators.email('john.doe@domain.com'), null);
    });

    test('should validate email with plus sign', () {
      expect(Validators.email('john+tag@domain.com'), null);
    });

    test('should validate email with subdomain', () {
      expect(Validators.email('john@sub.domain.com'), null);
    });

    test('should validate email with uppercase characters', () {
      expect(Validators.email('John.Doe@Domain.Com'), null);
    });

    test('should validate email with hyphens', () {
      expect(Validators.email('john-doe@my-domain.com'), null);
    });

    test('should handle long TLDs', () {
      expect(Validators.email('john@domain.travel'), null);
    });

    test('should reject email with invalid characters', () {
      expect(Validators.email('john#doe@domain.com'),
          'Please enter a valid email address');
    });

    test('should reject email with multiple @ symbols', () {
      expect(Validators.email('john@doe@domain.com'),
          'Please enter a valid email address');
    });
  });
}
