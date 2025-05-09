import 'package:flutter/material.dart';
import 'package:smart_lib_form_elements/form/base/validation/smart_validator_text_form_field.dart';

/// A specialized text input widget that extends `SmartValidatorTextFormField` to provide consistent theming and styling.
/// This widget is designed to be used as a base for form text fields, ensuring a unified appearance across the application.
class SmartFormText extends SmartValidatorTextFormField {
  /// Creates a `SmartFormText` widget with customizable properties for appearance and behavior.
  const SmartFormText({
    super.key,
    required super.value,
    required super.controller,
    super.onTextChanged,
    super.onFocusChanged,
    required super.validator,
    super.readOnly = false,
    super.labelText,
    super.obscureText = false,
    super.suffixIcon,
    super.textInputType,
    super.hintText,
    super.enable = true,
    super.inputFormatters,
    super.maxLines,
    super.maxLength,
    super.isFixLabel,
  });

  @override
  Color? enableBackgroundColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface; // Background color for enabled state.

  @override
  Color? disableBackgroundColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface; // Background color for disabled state.

  @override
  Color? hintTextColor(BuildContext context) =>
      TextTheme.of(context).bodySmall?.color?.withOpacity(0.5); // Color for placeholder text.

  @override
  Color? textColor(BuildContext context) =>
      TextTheme.of(context).bodySmall?.color; // Color for the input text.

  @override
  Color? errorTextColor(BuildContext context) =>
      Theme.of(context).colorScheme.error; // Color for error messages.

  @override
  Color? labelTextColor(BuildContext context) =>
      TextTheme.of(context).bodySmall?.color; // Color for the label text.
}
