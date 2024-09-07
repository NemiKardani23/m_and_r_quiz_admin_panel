import 'package:m_and_r_quiz_admin_panel/view/app_management/app_my_learning/diloag/add_my_learning_category_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/model/my_learning_category_list_model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../../export/___app_file_exporter.dart';

class AppMyLearningScreen extends StatefulWidget {
  const AppMyLearningScreen({super.key});

  @override
  State<AppMyLearningScreen> createState() => _AppMyLearningScreenState();
}

class _AppMyLearningScreenState extends State<AppMyLearningScreen> {
  DataHandler<List<MyLearningCategoryListModel>> myLearningCategoryData = DataHandler();
  @override
  Widget build(BuildContext context) {
    return MyScaffold(context: context, myBody: _body(context));
  }

  Widget _body(BuildContext context) {
    return MyScrollView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRegularText(
              align: TextAlign.start,
              label: myLearningStr,
              fontSize: NkFontSize.headingFont,
            ),
            FittedBox(
              child: MyThemeButton(
                  padding: 10.horizontal,
                  leadingIcon: const Icon(
                    Icons.add,
                    color: secondaryIconColor,
                  ),
                  buttonText: "$addStr $categoryStr",
                  onPressed: () {
                    showAdaptiveDialog(
                        context: context,
                        builder: (builder) {
                          return AddMyLearninCategoryDiloag(
                            onUpdate: (updatedCategory) {
                              
                              if (myLearningCategoryData.data != null &&
                                  myLearningCategoryData.data!.isNotEmpty) {
                                myLearningCategoryData.data?.add(updatedCategory!);
                              } else {
                                myLearningCategoryData.onSuccess([updatedCategory!]);
                              }
                            },
                          );
                        }).then(
                      (value) => setState(() {}),
                    );
                  }),
            )
          ],
        ),
      ],
    );
  }

  // Widget boardList() {
  //   return boardListData.when(
  //     context: context,
  //     successBuilder: (boardList) {
  //       return ResponsiveGridList(
  //         minItemWidth: context.isMobile ? context.width : 300,
  //         minItemsPerRow: 1,
  //         maxItemsPerRow: 4,
  //         children: List.generate(boardList.length, (index) {
  //           return boardComponent(boardList[index], index);
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
}
