import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/buttons/button.dart';
import 'package:flutter_core_ui_kit/flutter_core_ui_kit.dart';
import 'package:flutter_core_ui_kit/form_fields/flutter/select_form_field/select_form_field_item.dart';
import 'package:flutter_core_ui_kit/form_fields/flutter/select_form_field/select_form_field_list_item.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class SelectFormFieldList<T> extends StatefulWidget {
  final List<SelectFormFieldItem<T>> items;
  final List<SelectFormFieldItem<T>>? initialValues;
  final bool hasMultipleSelection;
  final Future<SelectFormFieldItem<T>?> Function()? onAddNew;

  const SelectFormFieldList({
    required this.items,
    this.hasMultipleSelection = false,
    this.initialValues,
    this.onAddNew,
  });

  @override
  _SelectFormFieldListState<T> createState() => _SelectFormFieldListState<T>();
}

class _SelectFormFieldListState<T> extends State<SelectFormFieldList<T>> {
  late List<Widget> children;
  List<SelectFormFieldItem<T>> _currentValues = [];

  @override
  void initState() {
    if (widget.initialValues != null) {
      _currentValues = [...(widget.initialValues ?? [])];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomizedAppBar(
        title: CoreUIKit.selectListTitle,
        leading: CustomizedAppBar.leadingButton(context, onPressed: () => Navigator.of(context).pop()),
        actions: [
          Button.icon(
            icon: Icons.check,
            onPressed: () => Navigator.of(context).pop<List<SelectFormFieldItem<T>>>(_currentValues),
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + Dimens.APP_BAR_HEIGHT + Dimens.SPACING_L,
          bottom: MediaQuery.of(context).padding.top + Dimens.SPACING_L,
        ),
        itemCount: widget.items.length + (widget.onAddNew == null ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == widget.items.length) {
            return _addNewItem();
          }
          final item = widget.items[index];
          final isSelected = _currentValues.contains(item);
          return SelectFormFieldListItem(
            label: item.label,
            selected: isSelected,
            onTap: () => _onTap(item, isSelected),
          );
        },
      ),
    );
  }

  Widget _addNewItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.SPACING_L),
      child: ListItem(
        backgroundColor: ThemeColors.of(context).primaryLight,
        trailing: Button.icon(
            icon: Icons.add,
            buttonColor: ThemeColors.of(context).primary,
            onPressed: () async {
              final result = await widget.onAddNew?.call();
              setState(() {
                if (result != null) {
                  widget.items.add(result);
                }
              });
            }),
        title: Text(
          CoreUIKit.addNewItemLabel,
          style: Theme.of(context).textTheme.headline5?.apply(color: ThemeColors.of(context).textColor), //todo change text
        ),
      ),
    );
  }

  void _onTap(SelectFormFieldItem<T> item, bool isSelected) {
    if (widget.hasMultipleSelection) {
      if (isSelected) {
        setState(() {
          _currentValues.remove(item);
        });
      } else {
        setState(() {
          _currentValues.add(item);
        });
      }
    } else {
      if (isSelected) {
        setState(() {
          _currentValues.clear();
        });
      } else {
        setState(() {
          _currentValues.clear();
          _currentValues.add(item);
        });
      }
    }
  }
}
