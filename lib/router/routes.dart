import 'package:m_and_r_quiz_admin_panel/components/my_network_image.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
import 'package:m_and_r_quiz_admin_panel/router/custom_page_builder.dart';
import 'package:m_and_r_quiz_admin_panel/view/auth/login_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/dahsboard/dashboard_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/questions/diloag/add_question_diloag.dart';

class AppRoutes {
  static const String loginScreen = "/login";
  static const String intro = "/intro";
  static const String dashboardScreen = "/dashboard";

  /// QUESTIONS
  static const String addQuestionScreen = "add-question";

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
                      routes: [
                        GoRoute(
                          path: addQuestionScreen,
                          name: addQuestionScreen,
                          // builder: (context, state) {
                          //   var mapData = state.extra as Map;
                          //   return AddQuestionDiloag(
                          //     boardList: mapData["boardList"],
                          //   );
                          // },
                          pageBuilder: (context, state) {
                            var mapData = state.extra as Map;
                            return CustomPageBuilder.getTransitionPage(
                                child: AddQuestionDiloag(
                                  boardList: mapData["boardList"],
                                ),
                                settings: state,
                                context: context,
                                state: state);
                          },
                        ),
                      ]),
                ])
          ])
    ];

    navigator = GoRouter(
      routes: routes,
      debugLogDiagnostics: true,
      routerNeglect: true,
      navigatorKey: $navigatorKey,
      initialLocation: loginScreen,
      redirect: (context, state) async {
        if (await SessionHelper.instance.getLoginData() == null) {
          return loginScreen;
        } else {
          if (state.name == dashboardScreen) {
            return dashboardScreen;
          } else {
            return state.fullPath;
          }
        }
      },
      observers: [AuthRouteObserver()],
      errorBuilder: (context, state) {
        return LayoutBuilder(builder: (context, consta) {
          return MyNetworkImage(
              appWidth: consta.maxWidth,
              appHeight: consta.maxHeight,
              url:
                  "https://cdn.dribbble.com/users/1138875/screenshots/4669703/media/c25729131efb71198034c0275c21aea8.gif");
        });
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
          AppRoutes.navigator.pushReplacementNamed(AppRoutes.loginScreen);
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
