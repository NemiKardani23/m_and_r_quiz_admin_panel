import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCommnonContainer(
            isCardView: true, margin: nkRegularPadding, child: _body),
      ],
    );
  }

  Widget get _body {
    return MyScrollView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRegularText(
              label: "$categoryStr $sectionStr",
              fontSize: NkFontSize.headingFont,
            ),
          ],
        ),
      ],
    );
  }
}
