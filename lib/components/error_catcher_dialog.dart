import 'package:flutter/material.dart';
import 'package:doctor_website/exports/exports.dart';
import 'package:doctor_website/styles/styles.dart';

class ErrorCatcherDialog extends StatelessWidget {
  const ErrorCatcherDialog({super.key, required this.errorText});
  final String errorText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      title: Text(context.loc.error),
      content: Container(
        decoration: Styles.CONTAINERDECORATION,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              errorText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
          label: Text(context.loc.close),
        ),
      ],
    );
  }
}
