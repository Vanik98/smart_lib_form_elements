import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable `TextFormField` widget that includes built-in validation and styling options.
/// This widget is designed to provide a flexible and reusable text input field with support for various configurations such as labels, hints, validators, and input constraints.
class SmartValidatorTextFormField extends StatefulWidget {
  final ValueChanged<String?>? onTextChanged;
  final ValueChanged<String?>? onFocusChanged;
  final String? value;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final bool readOnly;
  final bool enable;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool? isFixLabel;

  /// Customizable color getters for different states of the text field.
  Color? errorTextColor(BuildContext context) => null;
  Color? labelTextColor(BuildContext context) => null;
  Color? hintTextColor(BuildContext context) => null;
  Color? enableBackgroundColor(BuildContext context) => null;
  Color? disableBackgroundColor(BuildContext context) => null;
  Color? textColor(BuildContext context) => null;

  const SmartValidatorTextFormField({
    super.key,
    required this.value,
    required this.controller,
    this.onTextChanged,
    this.onFocusChanged,
    required this.validator,
    this.readOnly = false,
    this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputType,
    this.hintText,
    this.enable = true,
    this.inputFormatters,
    this.maxLines,
    this.maxLength,
    this.isFixLabel,
  });

  @override
  SmartValidatorTextFormFieldState createState() => SmartValidatorTextFormFieldState();
}

/// The state class for `SmartValidatorTextFormField`.
/// Manages the focus and lifecycle of the text field, as well as its dynamic behavior such as focus changes and text updates.
class SmartValidatorTextFormFieldState extends State<SmartValidatorTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.text = widget.value ?? "";
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  /// Handles focus change events and triggers the `onFocusChanged` callback if provided.
  void _handleFocusChange() {
    if (widget.onFocusChanged != null) {
      widget.onFocusChanged!(_focusNode.hasFocus ? 'focused' : 'unfocused');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      focusNode: _focusNode,
      controller: widget.controller,
      onChanged: widget.onTextChanged,
      readOnly: widget.readOnly,
      enabled: widget.enable,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      inputFormatters: widget.inputFormatters,
      style: TextTheme.of(context).bodyMedium?.copyWith(color: widget.textColor(context)),
      decoration: InputDecoration(
        floatingLabelBehavior: widget.isFixLabel == true ? FloatingLabelBehavior.always : null,
        suffixIcon: widget.suffixIcon,
        labelStyle: smartTextFormFieldLabelStyle(),
        fillColor: widget.enable
            ? widget.enableBackgroundColor(context)
            : widget.disableBackgroundColor(context),
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintTextColor(context)),
        labelText: widget.labelText,
        border: disableTextFormFieldBorder(),
        enabledBorder: enableTextFormFieldBorder(),
        disabledBorder: disableTextFormFieldBorder(),
        focusedBorder: smartTextFormFieldFocusedBorder(),
        errorBorder: smartTextFormFieldErrorBorder(),
        focusedErrorBorder: smartTextFormFieldFocusedErrorBorder(),
      ),
      validator: widget.validator,
    );
  }

  /// Defines the style for the label text of the text field.
  TextStyle smartTextFormFieldLabelStyle() =>
      TextStyle(color: widget.labelTextColor(context), fontSize: 14);

  /// Defines the border style for the disabled state of the text field.
  InputBorder disableTextFormFieldBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: widget.disableBackgroundColor(context) ?? Colors.black,
    ),
  );

  /// Defines the border style for the enabled state of the text field.
  InputBorder enableTextFormFieldBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: widget.enableBackgroundColor(context) ?? Colors.black,
    ),
  );

  /// Defines the border style for the focused state of the text field.
  InputBorder smartTextFormFieldFocusedBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: widget.enableBackgroundColor(context)?.withOpacity(0.4) ??
          Colors.black,
    ),
  );

  /// Defines the border style for the error state of the text field.
  InputBorder smartTextFormFieldErrorBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: widget.errorTextColor(context) ?? Colors.red,
    ),
  );

  /// Defines the border style for the focused error state of the text field.
  InputBorder smartTextFormFieldFocusedErrorBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: widget.errorTextColor(context) ?? Colors.red,
    ),
  );
}