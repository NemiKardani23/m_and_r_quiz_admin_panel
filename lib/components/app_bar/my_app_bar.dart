import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class MyAppBar extends PreferredSize {
  final String heading;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets padding;
  final bool isShowBackButton;
  final Function()? onTrailingTap;
  const MyAppBar({
    super.key,
    required this.heading,
    this.leading,
    this.trailing,
    this.onTrailingTap,
    this.isShowBackButton = true,
    this.padding = EdgeInsets.zero,
  }) : super(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: const SizedBox());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      contentPadding: padding,
      tileColor: transparent,
      focusColor: transparent,
      hoverColor: transparent,
      selectedTileColor: transparent,
      selectedColor: transparent,
      title: Hero(
        tag: heading,
        child: MyRegularText(
          label: heading,
          fontWeight: NkGeneralSize.nkBoldFontWeight,
          align: TextAlign.start,
          fontSize: NkFontSize.headingFont,
        ),
      ),
      leading: leading,
      trailing: isShowBackButton ? _backButton(context) : trailing,
    );
  }

  Widget _backButton(BuildContext context) {
    return const CloseButton();
  }
}
