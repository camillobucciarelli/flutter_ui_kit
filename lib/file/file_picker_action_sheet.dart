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

class FilePickerActionSheet {
  final String galleryActionLabel;
  final String cameraActionLabel;
  final bool onlyImages;
  final List<String>? allowedExtensions;
  final bool onlyFromGallery;
  final bool enableCrop;
  final bool cropCircle;

  FilePickerActionSheet({
    required this.galleryActionLabel,
    required this.cameraActionLabel,
    this.allowedExtensions,
    this.onlyImages = true,
    this.onlyFromGallery = false,
    this.enableCrop = false,
    this.cropCircle = false,
  });

  void show(
    BuildContext context, {
    AdaptiveStyle style = AdaptiveStyle.adaptive,
    OnFileSelected? onFileSelected,
    OnError? onError,
  }) async {
    if (kIsWeb || onlyFromGallery) {
      if (onlyImages) {
        _getImage(ImageSource.gallery, context, onFileSelected, onError);
      } else {
        _getFile(context, onFileSelected, onError);
      }
    } else {
      final result = await showModalActionSheet<ImageSource>(
        context: context,
        actions: [
          SheetAction(
              key: ImageSource.gallery,
              label: galleryActionLabel,
              icon: Icons.photo_library_rounded),
          SheetAction(
            key: ImageSource.camera,
            label: cameraActionLabel,
            icon: Icons.photo_camera_rounded,
          ),
        ],
        style: style,
      );
      if(result != null) {
        if (result == ImageSource.gallery && !onlyImages) {
          _getFile(context, onFileSelected, onError);
        } else {
          _getImage(result, context, onFileSelected, onError);
        }
      }
    }
  }

  void _getFile(BuildContext context, OnFileSelected? onFileSelected,
      OnError? onError) async {
    final result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      withData: true,
      type: allowedExtensions?.isEmpty ?? true ? FileType.any : FileType.custom,
      allowedExtensions:
          allowedExtensions?.isEmpty ?? true ? null : allowedExtensions,
    );
    if (result != null &&
        result.files.single.path != null &&
        result.files.single.bytes != null) {
      onFileSelected?.call(
          PickedFile(result.files.single.path!, result.files.single.bytes!));
    }
  }

  void _getImage(ImageSource source, BuildContext context,
      OnFileSelected? onImageSelected, OnError? onError) async {
    try {
      final pickedFile = await ImagePicker().getImage(
          source: source, maxHeight: 1024, maxWidth: 1024, imageQuality: 70);
      final selectedImage = await pickedFile?.readAsBytes();
      if(selectedImage != null) {
        if (enableCrop) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => CropImage(
                imageData: selectedImage,
                circle: cropCircle,
                onCropped: (data) =>
                    onImageSelected?.call(PickedFile(pickedFile!.path, data)),
              ),
            ),
          );
        } else {
          onImageSelected?.call(PickedFile(pickedFile!.path, selectedImage));
        }
      }
    } catch (e) {
      if (!kIsWeb &&
          e is PlatformException &&
          (e.code == 'camera_access_denied' ||
              e.code == 'photo_access_denied')) {
        final result = await showOkCancelAlertDialog(
          context: context,
          title: CoreUIKit.filePickerPermissionTitle,
          message: CoreUIKit.filePickerPermissionMessageByCode(e.code),
          okLabel: CoreUIKit.okButtonText,
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
