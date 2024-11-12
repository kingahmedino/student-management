import 'package:flutter/material.dart';

class UploadProgressIndicator extends StatelessWidget {
  final double progress;
  final String message;

  const UploadProgressIndicator({
    super.key,
    required this.progress,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
            valueColor:
                AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
