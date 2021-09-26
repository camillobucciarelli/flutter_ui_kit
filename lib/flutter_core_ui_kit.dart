library flutter_core_ui_kit;

import 'package:flutter/material.dart';

import 'theme/core_theme.dart';

export 'adaptive_container.dart';
export 'buttons/button.dart';
export 'buttons/context_menu_icon_button.dart';
export 'customized_app_bar.dart';
export 'expansion_card.dart';
export 'file/crop_image.dart';
export 'file/file_picker_action_sheet.dart';
export 'form_fields/flutter/alphanumeric_form_field.dart';
export 'form_fields/flutter/number_form_field.dart';
export 'form_fields/flutter/select_form_field/multi_select_form_field.dart';
export 'form_fields/flutter/select_form_field/select_form_field.dart';
export 'form_fields/flutter/select_form_field/select_form_field_item.dart';
export 'form_fields/flutter/select_form_field/select_form_field_list.dart';
export 'form_fields/flutter/select_form_field/select_form_field_list_item.dart';
export 'form_fields/flutter/text_input_formatters/mask_text_input_formatter.dart';
export 'form_fields/reactive_forms_fields/reactive_alphanumeric_field.dart';
export 'header.dart';
export 'lists/list_item.dart';
export 'lists/list_item_group.dart';
export 'lists/list_with_bottom.dart';
export 'lists/paginated/load_more_delegate.dart';
export 'lists/paginated/paginated_list_view.dart';
export 'lists/paginated/paginated_sliver_list.dart';
export 'page_view/indicator_item.dart';
export 'page_view/page_view_indicator.dart';
export 'shadowed_container.dart';
export 'shimmer_container.dart';
export 'sliver_app_bar_delegate.dart';
export 'sliver_tab_bar_delegate.dart';
export 'snack_bar_overlay.dart';
export 'theme/core_theme.dart';
export 'timer_widget_builder.dart';
export 'toast.dart';
export 'user_avatar.dart';
export 'utils.dart';

class CoreUIKit {
  static late final OnBack genericBackAction;

  static void init({
    required ThemeColors themeColorsLight,
    required ThemeColors themeColorsDark,
    required String fontFamily,
    OnBack? genericBackAction,
  }) {
    CoreTheme.init(themeColorsLight: themeColorsLight, themeColorsDark: themeColorsDark, fontFamily: fontFamily);
    CoreUIKit.genericBackAction = genericBackAction ?? _back;
  }

  static void _back<T extends Object?>(BuildContext context, T? result) {}
}

typedef OnBack = void Function<T extends Object?>(BuildContext context, T? result);
