import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../base/smart_form_selector.dart';

/// A customizable calendar input widget that allows users to select a date using a date picker dialog.
/// This widget integrates with `SmartFormSelector` to provide a read-only text field with a calendar icon for triggering the date picker.
class FormElementCalendarWidget extends StatefulWidget {
  /// Callback function triggered when a date is selected. The selected date is passed as a formatted string (`DD/MM/YYYY`).
  final Function(String) onDateSelected;

  /// The initial date value displayed in the text field. If provided, it must be in the format `DD/MM/YYYY`.
  final String? initialValue;

  /// Determines whether selecting a date is mandatory. If `false`, validation will not enforce a required value.
  final bool? isImageRequired;

  /// Optional label text displayed above the input field.
  final String? labelText;

  /// Custom error message displayed when validation fails (e.g., when no date is selected and `isImageRequired` is `true`).
  final String? errorText;

  const FormElementCalendarWidget({
    super.key,
    required this.onDateSelected,
    this.initialValue,
    this.isImageRequired = true,
    this.labelText,
    this.errorText,
  });

  @override
  State<FormElementCalendarWidget> createState() => _FormElementCalendarWidgetState();
}

class _FormElementCalendarWidgetState extends State<FormElementCalendarWidget> {
  /// Stores the selected date as a formatted string (`DD/MM/YYYY`).
  String? _selectedDate;

  /// Stores the currently inputting or selected date as a `DateTime` object.
  DateTime? _inputtingDateTime;

  /// Controller for managing the text displayed in the input field.
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    // Initialize the selected date and text controller with the initial value, if provided.
    _selectedDate = widget.initialValue;
    _textEditingController = TextEditingController(text: _selectedDate);
  }

  @override
  void dispose() {
    // Dispose of the text controller to free resources.
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartFormSelector(
      textEditingController: _textEditingController,
      labelText: widget.labelText,
      hintText: 'DD/MM/YYYY', // Placeholder text for the input field.
      validator: (value) {
        // Validation logic: Ensures a date is selected if `isImageRequired` is `true`.
        if (widget.isImageRequired == false) return null;
        if (_selectedDate == null) {
          return widget.errorText ?? "error"; // Default error message if none is provided.
        }
        return null; // No validation error if a date is selected.
      },
      selectedValue: _selectedDate, // Displays the selected date in the input field.
      onSelect: _onSelect, // Triggers the date picker dialog when the widget is tapped.
      icon: Icon(
        Icons.calendar_month,
        color: TextTheme.of(context).bodySmall?.color, // Calendar icon color.
      ),
    );
  }

  /// Opens the date picker dialog and updates the selected date when a date is chosen.
  void _onSelect() async {
    // Define the range of selectable dates (up to 100 years in the past from today).
    DateTime now = DateTime.now();
    DateTime lastDate = now;
    DateTime firstDate = now.subtract(const Duration(days: 365 * 100));

    // Show the date picker dialog with custom styling.
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      lastDate: lastDate,
      currentDate: _inputtingDateTime, // Pre-selects the current inputting date, if any.
      builder: (BuildContext context, Widget? widget) => Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme,
          datePickerTheme: DatePickerThemeData(
            rangePickerShadowColor: Colors.transparent,
            shadowColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            dividerColor: TextTheme.of(context).bodySmall?.color,
            headerBackgroundColor: Theme.of(context).colorScheme.primary,
            headerForegroundColor: TextTheme.of(context).headlineSmall?.color,
            headerHeadlineStyle: TextTheme.of(context).headlineSmall,
            dayForegroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                if (states.contains(MaterialState.selected)) {
                  return TextTheme.of(context).headlineLarge?.color ?? Colors.white;
                }
                return TextTheme.of(context).bodySmall?.color ?? Colors.grey;
              },
            ),
            dayStyle: Theme.of(context).textTheme.headlineSmall,
            yearForegroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context).colorScheme.onSecondary;
                }
                return TextTheme.of(context).bodySmall?.color ?? Colors.grey;
              },
            ),
          ),
        ),
        child: widget!,
      ),
    );

    // Update the state and notify the parent widget if a date is selected.
    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(pickedDate); // Format the selected date.
        _textEditingController.text = _selectedDate!; // Update the text field.
        widget.onDateSelected(_selectedDate!); // Notify the parent widget of the selected date.
      });
    }
  }
}