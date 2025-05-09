import 'dart:io';

import 'package:flutter/material.dart';

class SmartPhotoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final File? selectedFile;

  const SmartPhotoWidget({
    super.key,
    this.width,
    this.height,
    this.selectedFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: selectedFile == null
            ? Center(
                child: Icon(
                  Icons.place,
                  size: (width ?? 150) / 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : Image.file(selectedFile!, fit: BoxFit.cover),
      ),
    );
  }
}
