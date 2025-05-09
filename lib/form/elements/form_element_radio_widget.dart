import 'package:flutter/material.dart';

import '../wrapper/form_element_wrapper.dart';

/// A customizable radio button group widget designed for use in forms, allowing users to select one option from a list.
/// This widget supports validation, error handling, and both horizontal and vertical layouts.
class FormElementRadioWidget<T> extends StatefulWidget {
  /// The list of options available for selection. Each option includes a title and associated data.
  final List<FormElement<T>> forms;

  /// Callback function triggered when an option is selected. Receives the data associated with the selected option.
  final Function(T) onDataSelected;

  /// Determines whether the radio buttons are displayed horizontally (`true`) or vertically (`false`).
  final bool isHorizontal;

  /// The title of the initially selected option (if any). If provided, this option will be pre-selected.
  final String? initialSelectedTitle;

  /// Determines whether selecting an option is mandatory. If `true`, validation will enforce that an option is selected.
  final bool? isImageRequired;

  /// Custom error message displayed when validation fails (e.g., when no option is selected and `isImageRequired` is `true`).
  final String? errorText;

  const FormElementRadioWidget({
    super.key,
    required this.forms,
    required this.onDataSelected,
    this.isHorizontal = true,
    this.initialSelectedTitle,
    this.isImageRequired = true,
    this.errorText,
  });

  @override
  State<FormElementRadioWidget> createState() => _FormElementRadioWidgetState<T>();
}

class _FormElementRadioWidgetState<T> extends State<FormElementRadioWidget<T>> {
  /// Tracks the currently selected option's title.
  String? _selectedTitle;

  /// The list of available options.
  late List<FormElement<T>> forms;

  @override
  void initState() {
    // Initialize the selected title and forms with the provided values.
    _selectedTitle = widget.initialSelectedTitle;
    forms = widget.forms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: _selectedTitle,
      validator: (value) {
        // Validation logic: Ensures an option is selected if `isImageRequired` is `true`.
        if (widget.isImageRequired == false) return null;
        if (value == null || value.isEmpty) {
          return widget.errorText ?? "error"; // Default error message if none is provided.
        }
        return null; // No validation error if an option is selected.
      },
      builder: (FormFieldState<String?> formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the radio buttons in either a horizontal or vertical layout.
            (widget.isHorizontal)
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getFormWidgets(formFieldState),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getFormWidgets(formFieldState),
            ),
            if (formFieldState.errorText != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  formFieldState.errorText!, // Display the validation error message.
                  style: TextTheme.of(context).bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onError, // Error text color.
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// Generates the list of radio button widgets based on the provided options.
  List<Widget> _getFormWidgets(FormFieldState<String?> formFieldState) => [
    ...forms.map((item) {
      return Row(
        children: [
          Radio<String>(
            activeColor: Theme.of(context).colorScheme.primary,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                  (states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context).colorScheme.primary;
                }
                return TextTheme.of(context).bodySmall?.color ?? Colors.grey;
              },
            ),
            value: item.title, // The title of the current option.
            groupValue: _selectedTitle, // The currently selected option's title.
            onChanged: (newValue) {
              setState(() {
                _selectedTitle = newValue; // Update the selected title.
                formFieldState.didChange(newValue); // Notify the form field of the change.
                widget.onDataSelected(item.data); // Notify the parent widget of the selected data.
              });
            },
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedTitle = item.title; // Update the selected title.
                formFieldState.didChange(item.title); // Notify the form field of the change.
                widget.onDataSelected(item.data); // Notify the parent widget of the selected data.
              });
            },
            child: Text(
              item.title, // Display the title of the current option.
              style: TextTheme.of(context).bodyMedium,
            ),
          ),
        ],
      );
    }),
  ];
}