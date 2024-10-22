import 'package:m_and_r_quiz_admin_panel/components/animation/common_animation/diloag_animation.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class MyDeleteDialog extends StatelessWidget {
  final String appBarTitle;
  final String deleteItemType;
  final Future<void> Function()? onPressed;
  const MyDeleteDialog(
      {super.key,
      required this.appBarTitle,
      this.deleteItemType = areYouSureYouWantToDelete,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.width * 0.25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyAppBar(
              heading: appBarTitle,
            ),
            nkSmallSizedBox,
            deleteButton(context),
            nkExtraSmallSizedBox,
            Padding(
              padding: 10.horizontal,
              child: MyRegularText(
                label: deleteItemType,
                fontSize: NkFontSize.largeFont,
              ),
            ),
            nkMediumSizedBox,
            bottomButtons(context),
          ],
        ),
      ),
    ).dialogAnimation;
  }

  Widget deleteButton(BuildContext context) {
    return ClipOval(
        child: ColoredBox(
            color: errorColor.withOpacity(0.2),
            child: Padding(
              padding: 16.0.all,
              child: const Icon(
                Icons.delete,
                color: errorColor,
                size: 40,
              ),
            )));
  }

  Widget bottomButtons(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      MyThemeButton(
        onPressed: () {
          Navigator.pop(context);
        },
        buttonText: closeStr,
        color: transparent,
        fontColor: primaryTextColor,
        shape:  RoundedRectangleBorder(
            side: BorderSide(
              color: secondaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      5.space,
      MyThemeButton(
        isLoadingButton: true,
        buttonText: deleteStr,
        onPressed: () async {
          await onPressed?.call().whenComplete(() => Navigator.pop(context));
        },
      )
    ]);
  }
}
