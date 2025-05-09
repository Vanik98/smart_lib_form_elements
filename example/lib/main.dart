import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_lib_form_elements/form/form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Defines the theme of the application using `ThemeData`.
      // This theme is configured to provide a consistent visual style for the form widgets.
      theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.blue.shade400,
            onPrimary: Colors.blue.shade900,
            secondary: Colors.blue.shade900,
            onSecondary: Colors.white,
            error: Colors.red.shade300,
            onError: Colors.red,
            surface: Colors.grey.shade700,
            onSurface: Colors.grey.shade200.withValues(alpha: 0.25 * 255),
          ),
          textTheme: TextTheme(
            bodySmall: TextStyle(color: Colors.grey.shade900),
            bodyMedium: TextStyle(color: Colors.grey.shade900),
          )),
      // The home screen of the application is set to `FormWidgets`, which contains various form elements.
      home: FormWidgets(),
    );
  }
}

/// The `FormWidgets` class is a StatelessWidget that demonstrates the usage of custom form elements.
/// It uses a `Form` widget to manage form validation and includes various custom widgets for different input types.
class FormWidgets extends StatelessWidget {
  // A GlobalKey is used to uniquely identify the Form widget and manage its state.
  final _formKey = GlobalKey<FormState>();

  FormWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the scaffold contains a `Padding` widget to add spacing around the form.
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
        child: Form(
          key: _formKey, // Associates the GlobalKey with this Form widget.
          child: Column(
            children: [
              // A custom text input widget for entering text.
              FormElementTextWidget(),

              // A custom checkbox widget with a title and an onChanged callback to log the checkbox state.
              FormElementCheckBoxWidget(
                  title: "CheckBox",
                  onChanged: (value) {
                    log("value -> $value"); // Logs the current value of the checkbox.
                  },
                  isChecked: false),

              // A custom radio button widget that allows selecting one option from a list.
              FormElementRadioWidget(
                  forms: [
                    FormElement(data: 12, title: "yes"), // Represents the "yes" option.
                    FormElement(data: 342, title: "no"), // Represents the "no" option.
                  ],
                  onDataSelected: (data) {
                    log("$data"); // Logs the selected data when a radio button is chosen.
                  }),

              // A custom photo selection widget that allows users to pick an image file.
              FormElementPhotoWidget(
                imageSize: 200, // Sets the size of the displayed image.
                onImageSelected: (File? image) {
                  log("image selected -> $image"); // Logs the selected image file.
                },
                isImageRequired: true, // Indicates whether an image is mandatory.
              ),

              // A custom phone number input widget.
              FormElementPhoneWidget(),

              // Adds vertical spacing between the form elements and the button.
              SizedBox(height: 100),

              // A button to validate the form and log the result.
              ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate(); // Validates the form fields.
                    log("$isValid"); // Logs whether the form is valid or not.
                  },
                  child: Text("check")) // Displays "check" as the button label.
            ],
          ),
        ),
      ),
    );
  }
}