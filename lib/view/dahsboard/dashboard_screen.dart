import 'package:m_and_r_quiz_admin_panel/components/mouse_hover/nk_hover_change_widget.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionmanager.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';

int selectedIndex = 0;

class DashboardScreen extends StatelessWidget {
  final StatefulNavigationShell child;
  const DashboardScreen({super.key, required this.child});

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    selectedIndex = child.currentIndex;
    nkDevLog("SELECTED INDEX : ${child.currentIndex}");
    return MyScaffold(
      context: context,
      myBody: myBody(context),
      myDrawer: context.isMobile ? _bar : null,
      myFloatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      myFloatingActionButton: context.isMobile ? drawerButton(context) : null,
    );
  }

  Widget myBody(BuildContext context) {
    return Flex(
      direction: context.isMobile ? Axis.vertical : Axis.horizontal,
      children: [
        if (!context.isMobile) ...[_bar],
        if (context.isLargeDesktop) ...[
          Flexible(child: navigatePage(context)),
        ] else ...[
          navigatePage(context),
        ],
        // if (context.isMobile) ...[_bar]
      ],
    );
  }

  Widget navigatePage(BuildContext context) {
    if (context.isLargeDesktop) {
      return Center(
        child: SizedBox(
          height: context.height,
          width: context.width / 2,
          child: child,
        ),
      );
    } else {
      return Expanded(child: child);
    }
  }

  Widget get _bar {
    return Builder(builder: (context) {
      return _AppMenu(
        selectedIndex: selectedIndex,
        onItemSelected: (int index) {
          Scaffold.of(context).closeDrawer();
          child.goBranch(index);
        },
      );
    });
  }

  Widget drawerButton(BuildContext context) {
    return const DrawerButton();
  }
}

class _AppMenu extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onItemSelected;
  const _AppMenu({required this.selectedIndex, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(right: 30),
      child: Drawer(
        shadowColor: shadowColor,
        width: 200,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: white.withOpacity(.2),
            ),
            borderRadius: NkGeneralSize.nkCommonBorderRadius),
        elevation: 0,
        child: Column(
          children: [
            Flexible(
              child: ListView(
                // shrinkWrap: true,
                padding: nkRegularPadding,
                children: <Widget>[
                  MyCommnonContainer(
                    color: transparent,
                    child: MyRegularText(
                      label: appNameStr,
                      fontSize: NkFontSize.headingFont,
                      fontWeight: NkGeneralSize.nkBoldFontWeight,
                    ),
                  ),
                  nkExtraSmallSizedBox,
                  _webTabBuilder(0,
                      onItemSelected: onItemSelected,
                      tabName: "Home",
                      icon: Icon(
                        Icons.home,
                        color: selctedIconColor(0),
                      )),
                  _webTabBuilder(1,
                      onItemSelected: onItemSelected,
                      tabName: "App",
                      icon: Icon(
                        Icons.app_settings_alt,
                        color: selctedIconColor(1),
                      )),
                  _webTabBuilder(2,
                      onItemSelected: onItemSelected,
                      tabName: utilsStr,
                      icon: Icon(
                        Icons.admin_panel_settings_rounded,
                        color: selctedIconColor(2),
                      )),
                  _webTabBuilder(3,
                      onItemSelected: onItemSelected,
                      tabName: categoryStr,
                      icon: Icon(
                        Icons.category,
                        color: selctedIconColor(3),
                      )),
                ].addSpaceEveryWidget(space: 10.space),
              ),
            ),
            nkSmallSizedBox,
            _webLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // Widget _mobileTabComponent(BuildContext context,
  //     {required BottomNavigationBarItem tabItem,
  //     required int index,
  //     Function(int)? onSelectedItem}) {
  //   return Flexible(
  //     fit: FlexFit.tight,
  //     child: InkResponse(
  //       onTap: () {
  //         onSelectedItem?.call(index);
  //       },
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           tabItem.icon,
  //           if (tabItem.label != null) ...[
  //             MyRegularText(
  //               fontSize: NkFontSize.smallFont,
  //               label: tabItem.label!,
  //               fontWeight: selectedIndex == index
  //                   ? NkGeneralSize.nkBoldFontWeight
  //                   : null,
  //               color: selectedIndex == index
  //                   ? primaryTextColor
  //                   : primaryTextColor.withOpacity(0.5),
  //             ),
  //           ]
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _webTabBuilder(int index,
      {required void Function(int)? onItemSelected,
      required String tabName,
      required Widget icon}) {
    return NkHoverChangeWidget.hoverWidget(
        child: Card(
          elevation: selectedIndex == index ? null : 0,
          color: selectedIndex == index ? selectionColor : null,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ListTile(
            minTileHeight: 30,
            selected: selectedIndex == index,
            minVerticalPadding: 0,
            horizontalTitleGap: 0,
            contentPadding: 8.all,
            onTap: () {
              onItemSelected?.call(index);
            },
            title: MyRegularText(
              maxlines: 1,
              label: tabName,
              color: selctedIconColor(index),
            ),
            leading: icon,
          ),
        ),
        hoverChild: Card(
          color: primaryHoverColor,
          elevation: selectedIndex == index ? null : 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ListTile(
            minTileHeight: 30,
            selected: selectedIndex == index,
            minVerticalPadding: 0,
            horizontalTitleGap: 0,
            contentPadding: 8.all,
            onTap: () {
              onItemSelected?.call(index);
            },
            title: MyRegularText(
              maxlines: 1,
              label: tabName,
              color: primaryHoverTextColor,
            ),
            leading: icon,
          ),
        ));
  }

  Widget _webLogoutButton(BuildContext context) {
    return _webTabBuilder(-1, onItemSelected: (int) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              alignment: context.isMobile || context.isTablet
                  ? null
                  : Alignment.bottomLeft,
              backgroundColor: primaryColor,
              title: MyRegularText(
                label: areYouSureYouWantToLogoutStr,
                fontSize: NkFontSize.headingFont,
                fontWeight: NkGeneralSize.nkBoldFontWeight,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const MyRegularText(
                      label: cancleStr,
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(errorColor.withOpacity(.2))),
                    onPressed: () {
                      ApiWorker().logout().then(
                        (value) {
                          if (value != null && value.status == true) {
                            SessionManager.clearData();
                            AppRoutes.navigator.refresh();
                          }
                        },
                      );
                    },
                    child: const MyRegularText(label: logoutStr)),
              ]).fadeLeftAnimation;
        },
      );
    },
        tabName: logoutStr,
        icon: const Icon(
          Icons.logout,
          color: errorColor,
        ));
  }

  Color selctedIconColor(int index) {
    if (selectedIndex == index) {
      return primaryIconColor;
    } else {
      return primaryIconColor.withOpacity(0.5);
    }
  }
}
