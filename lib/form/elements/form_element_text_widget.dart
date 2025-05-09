import 'package:flutter/material.dart';

import '../base/smart_form_text.dart';

/// A customizable text input widget designed for use in forms, with built-in validation and error handling.
/// This widget ensures that the input meets a minimum length requirement and provides feedback through callbacks.
class FormElementTextWidget extends StatefulWidget {
  /// Callback function triggered when the text in the input field changes. Receives the updated text value.
  final ValueChanged<String?>? onTextChanged;

  /// Callback function triggered when the input field gains or loses focus. Receives the focus state as a string ("focused" or "unfocused").
  final ValueChanged<String?>? onFocusChanged;

  /// The initial text value displayed in the input field. If not provided, the field starts empty.
  final String? initialValue;

  /// Optional label text displayed above the input field.
  final String? labelText;

  /// Custom error message displayed when validation fails (e.g., when the input is too short).
  final String? errorText;

  /// Optional placeholder text displayed when the input field is empty.
  final String? hintText;

  const FormElementTextWidget({
    super.key,
    this.onTextChanged,
    this.onFocusChanged,
    this.initialValue,
    this.labelText,
    this.errorText,
    this.hintText,
  });

  @override
  State<FormElementTextWidget> createState() => _FormElementTextWidgetState();
}

class _FormElementTextWidgetState extends State<FormElementTextWidget> {
  /// Controller for managing the text input field's content and behavior.
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controller with the provided `initialValue` or an empty string.
    textEditingController = TextEditingController(text: widget.initialValue ?? '');
    textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Dispose of the text controller to free resources.
    textEditingController.dispose();
    super.dispose();
  }

  /// Notifies the parent widget of text changes via the `onTextChanged` callback.
  void _onTextChanged() {
    if (widget.onTextChanged != null) {
      widget.onTextChanged!(textEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartFormText(
      hintText: widget.hintText, // Placeholder text for the input field.
      controller: textEditingController, // Manages the input field's text content.
      labelText: widget.labelText, // Label text displayed above the input field.
      onTextChanged: widget.onTextChanged, // Callback for text changes.
      onFocusChanged: widget.onFocusChanged, // Callback for focus changes.
      validator: (value) {
        // Validation logic: Ensures the input meets the minimum length requirement (3 characters).
        if (value.length < 3) {
          return widget.errorText ?? "error"; // Default error message if none is provided.
        }
        return null; // No validation error if the input meets the requirement.
      },
      value: widget.initialValue ?? "", // Initial value for the input field.
    );
  }
}