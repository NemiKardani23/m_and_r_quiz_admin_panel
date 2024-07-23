import 'dart:ui';

extension ColorExtention on String {
  Color get toColor => Color(int.parse(replaceAll('#', '0xff'))); //
}
