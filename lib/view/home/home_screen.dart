import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyScrollView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _totalStudentCountWidget(context),
              _totalQuizCountWidget(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _totalStudentCountWidget(BuildContext context) {
    return MyCommnonContainer(
      isCardView: true,
      boxConstraints: BoxConstraints.loose(
        const Size.square(180),
      ),
      padding: nkRegularPadding,
      child: FutureBuilder(
          // future: TempDataStore.getStudentCount,
          future: Future.value(1),
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyRegularText(
                  label: snapshot.data?.toString() ?? "0",
                  fontSize: NkFontSize.headingFont,
                  fontWeight: NkGeneralSize.nkBoldFontWeight,
                ),
                const MyRegularText(
                  label: totalStudentStr,
                )
              ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
            );
          }),
    );
  }

  Widget _totalQuizCountWidget(BuildContext context) {
    return MyCommnonContainer(
      isCardView: true,
      boxConstraints: BoxConstraints.loose(
        const Size.square(180),
      ),
      padding: nkRegularPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyRegularText(
            label: "0",
            fontSize: NkFontSize.headingFont,
            fontWeight: NkGeneralSize.nkBoldFontWeight,
          ),
          const MyRegularText(
            label: totalQuizStr,
          )
        ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
      ),
    );
  }
}
