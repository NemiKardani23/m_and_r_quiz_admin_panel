import 'package:m_and_r_quiz_admin_panel/components/my_common_container.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/basic_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/home/home_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/questions/questions_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/student/student_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  final List<Widget> pageList = [
    const HomeScreen(),
    const BasicScreen(),
    const StudentScreen(),
    const QuestionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(context: context, myBody: myBody);
  }

  Widget get myBody {
    return Flex(
      direction: context.isMobile ? Axis.vertical : Axis.horizontal,
      children: [
        if (!context.isMobile) ...[_bar],
        navigatePage(),
        if (context.isMobile) ...[_bar]
      ],
    );
  }

  Widget navigatePage() {
    return Expanded(
      child: pageList[selectedIndex],
    );
  }

  Widget get _bar {
    return _AppMenu(
      selectedIndex: selectedIndex,
      onItemSelected: (int index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}

class _AppMenu extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onItemSelected;
  const _AppMenu({required this.selectedIndex, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return Card(
        child: ClipOval(
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              fixedColor: secondaryBackgroundColor,
              onTap: onItemSelected,
              unselectedLabelStyle: TextStyle(
                color: primaryTextColor.withOpacity(0.5),
              ),
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: basicStr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                  ),
                  label: "Student",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                  ),
                  label: "Questions",
                ),
              ]),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Drawer(
          shadowColor: secondaryColor,
          width: 200,
          shape: RoundedRectangleBorder(
              borderRadius: NkGeneralSize.nkCommonBorderRadius),
          elevation: 10,
          child: ListView(
            shrinkWrap: true,
            padding: nkRegularPadding,
            children: <Widget>[
              MyCommnonContainer(
                child: MyRegularText(
                  label: appNameStr,
                  fontSize: NkFontSize.headingFont,
                  fontWeight: NkGeneralSize.nkBoldFontWeight,
                ),
              ),
              _webTabBuilder(0,
                  onItemSelected: onItemSelected,
                  tabName: "Home",
                  icon: Icon(
                    Icons.home,
                    color: selctedIconColor(0),
                  )),
              _webTabBuilder(1,
                  onItemSelected: onItemSelected,
                  tabName: basicStr,
                  icon: Icon(
                    Icons.category,
                    color: selctedIconColor(1),
                  )),
              _webTabBuilder(2,
                  onItemSelected: onItemSelected,
                  tabName: "Student",
                  icon: Icon(
                    Icons.people,
                    color: selctedIconColor(2),
                  )),
              _webTabBuilder(3,
                  onItemSelected: onItemSelected,
                  tabName: "Questions",
                  icon: Icon(
                    Icons.people,
                    color: selctedIconColor(3),
                  )),
            ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
          ),
        ),
      );
    }
  }

  Widget _webTabBuilder(int index,
      {required void Function(int)? onItemSelected,
      required String tabName,
      required Widget icon}) {
    return Card(
      elevation: selectedIndex == index ? null : 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        selected: selectedIndex == index,
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        contentPadding: 10.all,
        onTap: () {
          onItemSelected?.call(index);
        },
        title: MyRegularText(
          label: tabName,
          color: selctedIconColor(index),
        ),
        leading: icon,
      ),
    );
  }

  Color selctedIconColor(int index) {
    if (selectedIndex == index) {
      return primaryIconColor;
    } else {
      return primaryIconColor.withOpacity(0.5);
    }
  }
}
