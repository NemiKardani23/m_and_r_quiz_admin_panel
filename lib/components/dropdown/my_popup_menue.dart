import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';

class MyPopUpMenu<T> extends StatelessWidget {
  final List<PopupMenuItem<T>> items;
  final Widget buttonChild;
  final ValueChanged<T>? onItemSelected;
  final String? tooltip;
  final ShapeBorder? shape;
  final Offset offset;
  final Color? color;
  final T? initialValue;
  final void Function()? onOpened;
  const MyPopUpMenu(
      {super.key,
      required this.items,
      required this.buttonChild,
      this.onItemSelected,
      this.tooltip,
      this.shape,
      this.offset = Offset.zero,
      this.color,
      this.initialValue,
      this.onOpened});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onOpened: onOpened,
      initialValue: initialValue,
      tooltip: tooltip,
      shape: shape,
      offset: offset,
      color: color,
      position: PopupMenuPosition.under,
      child: buttonChild,
      onSelected: (value) {
        onItemSelected?.call(value);
      },
      itemBuilder: (context) {
        return items /*List.generate(items.length, (index) {
          return items[index]??PopupMenuItem(
            mouseCursor: MaterialStateMouseCursor.clickable,
            child: Text('button no $index'),
          );
        })*/
            ;
      },
    );
  }

  static Widget popupButtonWidget(
      {required String title, bool isOpen = false}) {
    return ListTile(
      title: MyRegularText(
        label: title,
      ),
      trailing: isOpen
          ? const Icon(Icons.arrow_drop_up)
          : const Icon(Icons.arrow_drop_down),
    );
  }
}
