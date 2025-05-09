import 'package:flutter/material.dart';

/// A customizable checkbox widget designed for use in forms, with support for validation and error handling.
/// This widget allows users to toggle a checkbox and provides feedback through a callback function.
class FormElementCheckBoxWidget extends StatefulWidget {
  /// The text label displayed next to the checkbox. Provides context or instructions for the user.
  final String? title;

  /// Callback function triggered when the checkbox state changes. Receives the new boolean value of the checkbox.
  final ValueChanged<bool> onChanged;

  /// The initial checked state of the checkbox. If not provided, defaults to `false`.
  final bool? isChecked;

  /// Determines whether the checkbox is interactive. If `false`, the checkbox cannot be toggled.
  final bool isEnabled;

  /// Custom error message displayed when validation fails (e.g., when the checkbox is required but not checked).
  final String? errorText;

  const FormElementCheckBoxWidget({
    super.key,
    required this.onChanged,
    required this.isChecked,
    this.title,
    this.isEnabled = true,
    this.errorText,
  });

  @override
  State createState() => _FormElementAgreeWidgetState();
}

class _FormElementAgreeWidgetState extends State<FormElementCheckBoxWidget> {
  /// Tracks the current checked state of the checkbox.
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    // Initialize the checkbox state with the provided `isChecked` value or default to `false`.
    _isChecked = widget.isChecked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState<dynamic> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.isEnabled
                  ? () {
                // Toggle the checkbox state when tapped and notify the parent widget via the `onChanged` callback.
                final value = !_isChecked;
                setState(() {
                  _isChecked = value;
                });
                widget.onChanged(_isChecked);
              }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _isChecked,
                    onChanged: widget.isEnabled
                        ? (bool? value) {
                      if (value != null) {
                        setState(() {
                          _isChecked = value;
                        });
                        widget.onChanged(_isChecked);
                      }
                    }
                        : null,
                    activeColor: Theme.of(context).colorScheme.primary, // Customizes the checkbox color.
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title ?? "",
                      style: const TextStyle(color: Colors.white), // Customize the text style as needed.
                    ),
                  ),
                ],
              ),
            ),
            if (field.errorText != null)
              Text(
                field.errorText!,
                style: const TextStyle(color: Colors.red), // Displays error messages in red.
              ),
          ],
        );
      },
      validator: (value) {
        // Validation logic: Ensures the checkbox is checked if no custom validation is provided.
        if (_isChecked != true) {
          return widget.errorText ?? "error"; // Default error message if none is provided.
        }
        return null; // No validation error if the checkbox is checked.
      },
    );
  }
}