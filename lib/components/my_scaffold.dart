import 'package:flutter/gestures.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class MyScaffold extends Scaffold {
  final BuildContext context;
  final Widget myBody;
  final bool myExtendBody;
  final bool myExtendBodyBehindAppBar;
  final Widget? myAppBar;
  final Widget? myDrawer;
  final Color? myBackgroundColor;
  final Widget? myBottomNavigationBar;
  final Widget? myFloatingActionButton;
  final FloatingActionButtonAnimator? myFloatingActionButtonAnimator;
  final FloatingActionButtonLocation? myFloatingActionButtonLocation;
  final bool myResizeToAvoidBottomInset;
  // final bool isFotterShow;
  final bool isLeftSafeArea;
  final bool isRightSafeArea;
  final bool isTopSafeArea;
  final bool isBottomSafeArea;
  final bool isBgAnimationShow;
  final EdgeInsets minimumPadding;

  const MyScaffold(
      {super.key,
      required this.context,
      // this.isFotterShow = false,
      required this.myBody,
      this.myExtendBody = false,
      this.isLeftSafeArea = true,
      this.isRightSafeArea = true,
      this.isBottomSafeArea = false,
      this.isTopSafeArea = true,
      this.minimumPadding = nkRegularPadding,
      this.myExtendBodyBehindAppBar = false,
      this.myAppBar,
      this.myDrawer,
      this.myBackgroundColor,
      this.myBottomNavigationBar,
      this.myFloatingActionButton,
      this.isBgAnimationShow = true,
      this.myFloatingActionButtonAnimator,
      this.myFloatingActionButtonLocation,
      this.myResizeToAvoidBottomInset = false})
      : super(
            drawer: myDrawer,
            body: myBody,
            extendBody: myExtendBody,
            extendBodyBehindAppBar: myExtendBodyBehindAppBar,
            // appBar: myAppBar,
            backgroundColor: myBackgroundColor,
            bottomNavigationBar: myBottomNavigationBar,
            floatingActionButton: myFloatingActionButton,
            floatingActionButtonAnimator: myFloatingActionButtonAnimator,
            floatingActionButtonLocation: myFloatingActionButtonLocation,
            resizeToAvoidBottomInset: myResizeToAvoidBottomInset);

  @override
  Widget? get body {
    return SafeArea(
        bottom: isBottomSafeArea,
        top: isTopSafeArea,
        left: isLeftSafeArea,
        right: isRightSafeArea,
        minimum: minimumPadding,
        child: Column(
          children: [
            if (myAppBar != null) ...[myAppBar!],
            Flexible(child: myBody),
          ],
        ));
  }
}
