import 'package:m_and_r_quiz_admin_panel/components/my_common_container.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/basic_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/home/home_screen.dart';
<<<<<<< Updated upstream
=======
import 'package:m_and_r_quiz_admin_panel/view/questions/questions_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/student/student_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/utills_management_screen.dart';
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
    const Placeholder(),
=======
    const StudentScreen(),
    const QuestionsScreen(),
    const AppManagementScreen(),
    const UtillsManagementScreen(),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ]),
=======
      return SizedBox(
        height: context.height * 0.12,
        child: PageView(
          clipBehavior: Clip.none,
          children: [
            Card(
              margin: nkRegularPadding,
              clipBehavior: Clip.antiAlias,
              child: ClipRRect(
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _mobileTabComponent(context,
                          index: 0,
                          onSelectedItem: onItemSelected,
                          tabItem: BottomNavigationBarItem(
                            icon: Icon(Icons.home, color: selctedIconColor(0)),
                            label: 'Home',
                          )),
                      _mobileTabComponent(
                        context,
                        index: 1,
                        onSelectedItem: onItemSelected,
                        tabItem: BottomNavigationBarItem(
                          icon: Icon(
                            Icons.category,
                            color: selctedIconColor(1),
                          ),
                          label: basicStr,
                        ),
                      ),
                      _mobileTabComponent(
                        context,
                        index: 2,
                        onSelectedItem: onItemSelected,
                        tabItem: BottomNavigationBarItem(
                          icon: Icon(
                            Icons.people,
                            color: selctedIconColor(2),
                          ),
                          label: "Student",
                        ),
                      ),
                      _mobileTabComponent(context,
                          index: 3,
                          onSelectedItem: onItemSelected,
                          tabItem: BottomNavigationBarItem(
                            icon: Icon(
                              Icons.people,
                              color: selctedIconColor(3),
                            ),
                            label: "Questions",
                          )),
                    ]),
              ),
            ),
            Card(
              margin: nkRegularPadding,
              clipBehavior: Clip.antiAlias,
              child: ClipRRect(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _mobileTabComponent(context,
                          index: 4,
                          onSelectedItem: onItemSelected,
                          tabItem: BottomNavigationBarItem(
                            icon: Icon(
                              Icons.app_settings_alt,
                              color: selctedIconColor(4),
                            ),
                            label: "App Management",
                          )),
                      _mobileTabComponent(context,
                          index: 5,
                          onSelectedItem: onItemSelected,
                          tabItem: BottomNavigationBarItem(
                            icon: Icon(
                              Icons.admin_panel_settings_rounded,
                              color: selctedIconColor(5),
                            ),
                            label: utilsManagementStr,
                          )),
                    ]),
              ),
            ),
          ],
>>>>>>> Stashed changes
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
                  tabName: "Settings",
                  icon: Icon(
                    Icons.settings,
                    color: selctedIconColor(2),
                  )),
<<<<<<< Updated upstream
=======
              _webTabBuilder(3,
                  onItemSelected: onItemSelected,
                  tabName: "Questions",
                  icon: Icon(
                    Icons.people,
                    color: selctedIconColor(3),
                  )),
              _webTabBuilder(4,
                  onItemSelected: onItemSelected,
                  tabName: "App Management",
                  icon: Icon(
                    Icons.app_settings_alt,
                    color: selctedIconColor(4),
                  )),
              _webTabBuilder(5,
                  onItemSelected: onItemSelected,
                  tabName: utilsManagementStr,
                  icon: Icon(
                    Icons.admin_panel_settings_rounded,
                    color: selctedIconColor(5),
                  )),
>>>>>>> Stashed changes
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
