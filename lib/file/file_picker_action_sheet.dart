import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core_ui_kit/file/crop_image.dart';
import 'package:flutter_core_ui_kit/flutter_core_ui_kit.dart';
import 'package:image_picker/image_picker.dart';

enum Source { camera, gallery, file }

class FilePickerActionSheet {
  final String galleryActionLabel;
  final String cameraActionLabel;
  final String fileActionLabel;
  final List<String>? allowedExtensions;
  final bool enableCrop;
  final bool cropCircle;
  final List<Source> sources;

  FilePickerActionSheet({
    required this.galleryActionLabel,
    required this.cameraActionLabel,
    required this.fileActionLabel,
    required this.sources,
    this.allowedExtensions,
    this.enableCrop = false,
    this.cropCircle = false,
  });

  void show(
    BuildContext context, {
    AdaptiveStyle style = AdaptiveStyle.adaptive,
    OnFileSelected? onFileSelected,
    OnError? onError,
  }) async {
    if (kIsWeb) {
      if (!sources.contains(Source.file)) {
        _getImage(ImageSource.gallery, context, onFileSelected, onError);
      } else {
        _getFile(context, onFileSelected, onError);
      }
    } else {
      final result = await showModalActionSheet<Source>(
        context: context,
        actions: [
          if (sources.contains(Source.gallery))
            SheetAction(
              key: Source.gallery,
              label: galleryActionLabel,
              icon: Icons.photo_library_rounded,
            ),
          if (sources.contains(Source.camera))
            SheetAction(
              key: Source.camera,
              label: cameraActionLabel,
              icon: Icons.photo_camera_rounded,
            ),
          if (sources.contains(Source.file))
            SheetAction(
              key: Source.file,
              label: fileActionLabel,
              icon: Icons.photo_camera_rounded,
            ),
        ],
        style: style,
      );
      switch(result) {
        case Source.camera:
          _getImage(ImageSource.camera, context, onFileSelected, onError);
          break;
        case Source.gallery:
          _getImage(ImageSource.gallery, context, onFileSelected, onError);
          break;
        case Source.file:
          _getFile(context, onFileSelected, onError);
          break;
        default:
      }
    }
  }

  void _getFile(BuildContext context, OnFileSelected? onFileSelected, OnError? onError) async {
    final result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      withData: true,
      type: allowedExtensions?.isEmpty ?? true ? FileType.any : FileType.custom,
      allowedExtensions: allowedExtensions?.isEmpty ?? true ? null : allowedExtensions,
    );
    if (result != null && result.files.single.path != null && result.files.single.bytes != null) {
      onFileSelected?.call(PickedFile(result.files.single.path!, result.files.single.bytes!));
    }
  }

  void _getImage(ImageSource source, BuildContext context, OnFileSelected? onImageSelected, OnError? onError) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source, maxHeight: 1024, maxWidth: 1024, imageQuality: 70);
      final selectedImage = await pickedFile?.readAsBytes();
      if (selectedImage != null) {
        if (enableCrop) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => CropImage(
                imageData: selectedImage,
                circle: cropCircle,
                onCropped: (data) => onImageSelected?.call(PickedFile(pickedFile!.path, data)),
              ),
            ),
          );
        } else {
          onImageSelected?.call(PickedFile(pickedFile!.path, selectedImage));
        }
      }
    } catch (e) {
      if (!kIsWeb && e is PlatformException && (e.code == 'camera_access_denied' || e.code == 'photo_access_denied')) {
        final result = await showOkCancelAlertDialog(
          context: context,
          title: CoreUIKit.filePickerPermissionTitle,
          message: CoreUIKit.filePickerPermissionMessageByCode(e.code),
          okLabel: CoreUIKit.filePickerPermissionOkButtonText,
          cancelLabel: CoreUIKit.cancelButtonText,
        );
        switch (result) {
          case OkCancelResult.ok:
            await AppSettings.openAppSettings();
            break;
          case OkCancelResult.cancel:
            break;
        }
      } else {
        onError?.call(e.toString());
      }
    }
  }
}

class PickedFile {
  final String path;
  final Uint8List data;

  String get name => path.split('/').last;

  String get extension => path.split('/').last.split('.').last;

  PickedFile(this.path, this.data);

  @override
  String toString() {
    return 'PickedFile{name: $name, extension: $extension, size: ${data.length} path: $path}';
  }
}

typedef OnFileSelected = void Function(PickedFile pickedFile);
typedef OnError = void Function(String errorMessage);
