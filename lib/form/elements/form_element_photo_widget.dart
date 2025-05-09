import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/utils/helper/gallery_image_helper.dart';
import '../../core/widgets/smart_photo_widget.dart';

typedef PhotoBuilder = Widget Function(File? file);

/// A customizable photo input widget designed for use in forms, allowing users to select an image from the gallery.
/// This widget supports validation, error handling, and custom image display logic using a builder function.
class FormElementPhotoWidget extends StatefulWidget {
  /// The initial image URL or path (if any) to be displayed in the widget.
  final String? image;

  /// Callback function triggered when an image is selected. Receives the selected image file as a `File?`.
  final Function(File?) onImageSelected;

  /// Determines whether selecting an image is mandatory. If `true`, validation will enforce that an image is selected.
  final bool isImageRequired;

  /// Optional size for the displayed image (width and height).
  final double? imageSize;

  /// Custom error message displayed when validation fails (e.g., when no image is selected and `isImageRequired` is `true`).
  final String? errorText;

  /// Optional builder function for customizing how the selected image is displayed.
  final PhotoBuilder? builder;

  const FormElementPhotoWidget({
    super.key,
    this.image,
    required this.onImageSelected,
    required this.isImageRequired,
    this.imageSize,
    this.errorText,
    this.builder,
  });

  @override
  State<FormElementPhotoWidget> createState() => _FormElementPhotoWidgetState();
}

class _FormElementPhotoWidgetState extends State<FormElementPhotoWidget> {
  /// Tracks the currently selected image file.
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return FormField<File?>(
      validator: (value) {
        // Validation logic: Ensures an image is selected if `isImageRequired` is `true`.
        if (!widget.isImageRequired) return null;
        if (value == null) {
          return widget.errorText ?? "error"; // Default error message if none is provided.
        }
        return null; // No validation error if an image is selected.
      },
      builder: (FormFieldState<File?> state) {
        return GestureDetector(
          onTap: () async {
            // Opens the gallery to allow the user to select an image.
            File? selectedImg = await GalleryImageHelper.getImage();
            if (selectedImg != null) {
              setState(() {
                _selectedFile = selectedImg; // Update the selected file.
                state.didChange(selectedImg); // Notify the form field of the change.
                widget.onImageSelected(selectedImg); // Notify the parent widget of the selected image.
              });
            }
          },
          child: Column(
            children: [
              // Display the selected image using either the default `SmartPhotoWidget` or a custom builder.
              widget.builder == null
                  ? SmartPhotoWidget(
                height: widget.imageSize,
                width: widget.imageSize,
                selectedFile: _selectedFile,
              )
                  : widget.builder!(_selectedFile),
              const SizedBox(height: 4),
              if (state.errorText != null)
                Text(
                  state.errorText!, // Display the validation error message.
                  style: TextTheme.of(context).bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onError, // Error text color.
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}