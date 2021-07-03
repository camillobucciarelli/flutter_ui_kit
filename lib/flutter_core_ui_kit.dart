library flutter_core_ui_kit;

import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

export 'user_avatar.dart';
export 'toast.dart';
export 'timer_widget_builder.dart';
export 'snack_bar_overlay.dart';
export 'sliver_tab_bar_delegate.dart';
export 'sliver_app_bar_delegate.dart';
export 'shimmer_container.dart';
export 'shadowed_container.dart';
export 'list_item_group.dart';
export 'list_item.dart';
export 'header.dart';
export 'expansion_card.dart';
export 'customized_app_bar.dart';
export 'connection_state_toast.dart';
export 'adaptive_container.dart';
export 'theme/core_theme.dart';
export 'form_fields/number_form_field.dart';
export 'form_fields/alphanumeric_form_field.dart';
export 'form_fields/select_form_field/multi_select_form_field.dart';
export 'form_fields/select_form_field/select_form_field.dart';
export 'form_fields/select_form_field/select_form_field_item.dart';
export 'form_fields/select_form_field/select_form_field_list.dart';
export 'form_fields/select_form_field/select_form_field_list_item.dart';
export 'form_fields/text_input_formatters/mask_text_input_formatter.dart';
export 'file/crop_image.dart';
export 'file/file_picker_action_sheet.dart';
export 'buttons/button.dart';
export 'buttons/context_menu_icon_button.dart';

class CoreUIKit {
  static late final String filePickerPermissionTitle;
  static late final String Function(String) filePickerPermissionMessageByCode;
  static late final String filePickerPermissionOkButtonText;
  static late final String cancelButtonText;
  static late final String selectListTitle;
  static late final String addNewItemLabel;
  static late final String connectionWarningMessage;
  static late final OnBack genericBackAction;

  static void init({
    required ThemeColors themeColorsLight,
    required ThemeColors themeColorsDark,
    String filePickerPermissionTitle = '',
    String Function(String)? filePickerPermissionMessageByCode,
    String filePickerPermissionOkButtonText = '',
    String cancelButtonText = '',
    String selectListTitle = '',
    String addNewItemLabel = '',
    String connectionWarningMessage = '',
    OnBack? genericBackAction,
  }) {
    CoreTheme.init(
      themeColorsLight,
      themeColorsDark,
    );
    CoreUIKit.filePickerPermissionTitle = filePickerPermissionTitle;
    CoreUIKit.filePickerPermissionMessageByCode = filePickerPermissionMessageByCode ?? (_) => '';
    CoreUIKit.filePickerPermissionOkButtonText = filePickerPermissionOkButtonText;
    CoreUIKit.cancelButtonText = cancelButtonText;
    CoreUIKit.selectListTitle = selectListTitle;
    CoreUIKit.addNewItemLabel = addNewItemLabel;
    CoreUIKit.connectionWarningMessage = connectionWarningMessage;
    CoreUIKit.genericBackAction = genericBackAction ?? _back;
  }

  static void _back<T extends Object?>(BuildContext context, T? result){}
}

typedef OnBack = void Function<T extends Object?>(BuildContext context, T? result);
