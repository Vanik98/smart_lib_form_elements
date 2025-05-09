import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_lib_form_elements/form/base/smart_form_text.dart';

/// A customizable selector widget designed for selecting values from a predefined list or external source.
/// This widget wraps a `SmartFormText` field to provide a read-only input with a tap gesture for triggering selection logic.
class SmartFormSelector extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final FormFieldValidator validator;
  final Icon? icon;
  final VoidCallback? onSelect;
  final String? selectedValue;
  final TextEditingController textEditingController;
  final Color? enableBackgroundColor;
  final Color? disableBackgroundColor;
  final List<TextInputFormatter>? inputFormatters;

  /// Creates a `SmartFormSelector` widget with customizable properties for appearance and behavior.
  const SmartFormSelector({
    super.key,
    required this.selectedValue,
    required this.textEditingController,
    this.hintText,
    required this.validator,
    this.icon,
    this.onSelect,
    this.labelText,
    this.enableBackgroundColor,
    this.disableBackgroundColor,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect, // Triggers the selection logic when the widget is tapped.
      child: AbsorbPointer(
        absorbing: true, // Disables user interaction with the underlying text field.
        child: SmartFormText(
          enable: onSelect == null, // Enables or disables the text field based on the presence of `onSelect`.
          controller: textEditingController, // Controls the text displayed in the field.
          suffixIcon: icon, // Displays an optional icon at the end of the text field.
          hintText: hintText, // Provides placeholder text when no value is selected.
          readOnly: true, // Ensures the text field is not editable by the user.
          value: selectedValue, // Displays the currently selected value in the field.
          labelText: labelText, // Displays a label above the text field.
          validator: validator, // Validates the selected value.
          inputFormatters: inputFormatters, // Applies formatting rules to the input (if applicable).
        ),
      ),
    );
  }
}