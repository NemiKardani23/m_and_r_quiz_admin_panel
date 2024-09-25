import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionmanager.dart';
import 'package:m_and_r_quiz_admin_panel/router/custom_page_builder.dart';
import 'package:m_and_r_quiz_admin_panel/view/auth/login_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/dahsboard/dashboard_screen.dart';

class AppRoutes {
  static const String loginScreen = "/login";
  static const String intro = "/intro";
  static const String dashboardScreen = "/dashboard";

  static GlobalKey<NavigatorState>? $navigatorKey = GlobalKey<NavigatorState>();

  static late final GoRouter navigator;

  AppRoutes.routesData() {
    final routes = [
      StatefulShellRoute.indexedStack(
          parentNavigatorKey: $navigatorKey,
          pageBuilder: (context, state, navigationShell) {
            return CustomPageBuilder.getTransitionPage(
              context: context,
              state: state,
              transitionType: TransitionType.rightToLeft,
              child: navigationShell,
              settings: state,
            );
          },
          //parentNavigatorKey: $navigatorKey,
          branches: [
            StatefulShellBranch(
                initialLocation: AppRoutes.loginScreen,
                observers: [
                  AuthRouteObserver()
                ],
                routes: [
                  GoRoute(
                    path: loginScreen,
                    name: loginScreen,
                    builder: (context, state) {
                      return const LoginScreen();
                    },
                    pageBuilder: (context, state) {
                      return CustomPageBuilder.getTransitionPage(
                          child: const LoginScreen(),
                          settings: state,
                          context: context,
                          state: state);
                    },
                  ),
                  GoRoute(
                    path: dashboardScreen,
                    name: dashboardScreen,
                    builder: (context, state) {
                      return const DashboardScreen();
                    },
                    pageBuilder: (context, state) {
                      return CustomPageBuilder.getTransitionPage(
                          child: const DashboardScreen(),
                          settings: state,
                          context: context,
                          state: state);
                    },
                  ),
                ])
          ])
    ];

    navigator = GoRouter(
      routes: routes,
      debugLogDiagnostics: true,
      navigatorKey: $navigatorKey,
      initialLocation: loginScreen,
      redirect: (context, state) async {
        if (await SessionHelper.instance.getLoginData() == null) {
          return loginScreen;
        } else {
          return dashboardScreen;
        }
      },
      observers: [AuthRouteObserver()],
      errorBuilder: (context, state) {
        return const FlutterLogo();
      },
    );
  }
}

class AuthRouteObserver extends NavigatorObserver {
  static handleRouteVerification(Route route) {
    if (route.isFirst || route.settings.name == AppRoutes.loginScreen) {
      return;
    } else {
      SessionHelper.instance.getLoginData().then((value) {
        if (value == null) {
          NKToast.error(title: ErrorStrings.sessionExpired);
          AppRoutes.navigator.goNamed(AppRoutes.loginScreen);
        } else if (value.isAdmin == false) {
          NKToast.error(title: ErrorStrings.unknownUserFound);
          SessionManager.clearData();
          AppRoutes.navigator.goNamed(AppRoutes.loginScreen);
          return;
        }
      });
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    handleRouteVerification(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    handleRouteVerification(newRoute!);
    super.didReplace();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    handleRouteVerification(route);
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    handleRouteVerification(route);
    super.didRemove(route, previousRoute);
  }
}
