import 'package:flutter/material.dart';

import '../base/smart_form_text.dart';

/// A customizable phone number input widget designed for use in forms, with built-in validation and formatting.
/// This widget ensures that the input starts with a "+" sign and matches a predefined phone number format.
class FormElementPhoneWidget extends StatefulWidget {
  /// Callback function triggered when the text in the input field changes. Receives the updated text value.
  final ValueChanged<String?>? onTextChanged;

  /// Callback function triggered when the input field gains or loses focus. Receives the focus state as a string ("focused" or "unfocused").
  final ValueChanged<String?>? onFocusChanged;

  /// Optional label text displayed above the input field.
  final String? labelText;

  /// Custom error message displayed when validation fails (e.g., when the input does not match the required phone number format).
  final String? errorText;

  /// Optional placeholder text displayed when the input field is empty.
  final String? hintText;

  const FormElementPhoneWidget({
    super.key,
    this.onTextChanged,
    this.onFocusChanged,
    this.labelText,
    this.errorText,
    this.hintText,
  });

  @override
  State<FormElementPhoneWidget> createState() => _FormElementPhoneWidgetState();
}

class _FormElementPhoneWidgetState extends State<FormElementPhoneWidget> {
  /// Controller for managing the text input field's content and behavior.
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controller with a default "+" sign to enforce proper phone number formatting.
    textEditingController = TextEditingController(text: '+');
    textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Dispose of the text controller to free resources.
    textEditingController.dispose();
    super.dispose();
  }

  /// Ensures the input always starts with a "+" sign and updates the cursor position accordingly.
  void _onTextChanged() {
    if (textEditingController.text.isEmpty) {
      textEditingController.text = '+'; // Re-add the "+" sign if the field is cleared.
    } else if (!textEditingController.text.startsWith('+')) {
      // Ensure the input starts with a "+" sign by prepending it if necessary.
      textEditingController.text = '+${textEditingController.text.replaceAll('+', '')}';
    }
    // Update the cursor position to the end of the text.
    textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: textEditingController.text.length),
    );

    // Notify the parent widget of the updated text value via the `onTextChanged` callback.
    if (widget.onTextChanged != null) {
      widget.onTextChanged!(textEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartFormText(
      hintText: widget.hintText, // Placeholder text for the input field.
      controller: textEditingController, // Manages the input field's text content.
      labelText: widget.labelText ?? "Phone Number", // Default label text if none is provided.
      onTextChanged: widget.onTextChanged, // Callback for text changes.
      onFocusChanged: widget.onFocusChanged, // Callback for focus changes.
      textInputType: const TextInputType.numberWithOptions(signed: true), // Restricts input to numeric values.
      validator: (value) {
        // Validation logic: Ensures the input matches the required phone number format.
        if (value == null || value.isEmpty) {
          return widget.errorText ?? "error"; // Default error message if none is provided.
        }
        RegExp regex = RegExp(phoneNumberRegex); // Regular expression for validating phone numbers.
        if (!regex.hasMatch(value)) {
          return widget.errorText ?? "error"; // Default error message if none is provided.
        }
        return null; // No validation error if the input matches the format.
      },
      value: "", // Initial value for the input field.
    );
  }

  /// Regular expression defining the valid phone number format: Starts with "+" followed by 9 to 19 digits.
  static const phoneNumberRegex = r'^\+[0-9]{9,19}$';
}