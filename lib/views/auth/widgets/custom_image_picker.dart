import 'dart:io';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final String label;
  final Function(File) onImageSelected;
  final File? initialImage;

  const CustomImagePicker({
    super.key,
    required this.label,
    required this.onImageSelected,
    this.initialImage,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final sizeInMB = file.lengthSync() / (1024 * 1024);
      if (sizeInMB > 2) {
        if (sizeInMB > 5) {
          ToastHelper.showError('Image must be less than 5MB');
          return;
        }
      }
      setState(() {
        _selectedImage = file;
      });
      widget.onImageSelected(file);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _selectedImage!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Center(
                    child: Icon(Icons.camera_alt, color: Colors.grey, size: 40),
                  ),
          ),
        ),
      ],
    );
  }
}
