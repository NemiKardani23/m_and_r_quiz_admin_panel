import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionmanager.dart';
import 'package:m_and_r_quiz_admin_panel/router/custom_page_builder.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/app_management_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/auth/login_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/basic_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/category_folder/category_folder_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/category_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/dahsboard/dashboard_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/home/home_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/questions/questions_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/student/student_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/utills_management_screen.dart';

class AppRoutes {
  static const String loginScreen = "/login";
  static const String intro = "/intro";
  static const String dashboardScreen = "/dashboard";
  static const String basicScreen = "/basic";
  static const String studentScreen = "/student";
  static const String questionsScreen = "/questions";
  static const String appManagementScreen = "/app-management";
  static const String utilsManagementScreen = "/utils-management";
  static const String categoryScreen = "/category";
  static const String subCategoryScreen = "sub-category";
  static const String subCategoryPass =
      "sub-category/:id/:lavel/:routeChildPath";

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
                ])
          ]),
      StatefulShellRoute.indexedStack(
          parentNavigatorKey: $navigatorKey,
          pageBuilder: (context, state, navigationShell) {
            return CustomPageBuilder.getTransitionPage(
              context: context,
              state: state,
              transitionType: TransitionType.rightToLeft,
              child: DashboardScreen(child: navigationShell),
              settings: state,
            );
          },
          branches: [
            StatefulShellBranch(
                observers: [AuthRouteObserver()],
                initialLocation: AppRoutes.dashboardScreen,
                routes: [
                  GoRoute(
                    path: dashboardScreen,
                    name: dashboardScreen,
                    builder: (context, state) {
                      return const HomeScreen();
                    },
                    pageBuilder: (context, state) {
                      return CustomPageBuilder.getTransitionPage(
                          child: const HomeScreen(),
                          settings: state,
                          context: context,
                          state: state);
                    },
                  ),
                ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: basicScreen,
                name: basicScreen,
                builder: (context, state) {
                  return const BasicScreen();
                },
                pageBuilder: (context, state) {
                  return CustomPageBuilder.getTransitionPage(
                      child: const BasicScreen(),
                      settings: state,
                      context: context,
                      state: state);
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: studentScreen,
                name: studentScreen,
                builder: (context, state) {
                  return const StudentScreen();
                },
                pageBuilder: (context, state) {
                  return CustomPageBuilder.getTransitionPage(
                      child: const StudentScreen(),
                      settings: state,
                      context: context,
                      state: state);
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: questionsScreen,
                name: questionsScreen,
                builder: (context, state) {
                  return const QuestionsScreen();
                },
                pageBuilder: (context, state) {
                  return CustomPageBuilder.getTransitionPage(
                      child: const QuestionsScreen(),
                      settings: state,
                      context: context,
                      state: state);
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: appManagementScreen,
                name: appManagementScreen,
                builder: (context, state) {
                  return const AppManagementScreen();
                },
                pageBuilder: (context, state) {
                  return CustomPageBuilder.getTransitionPage(
                      child: const AppManagementScreen(),
                      settings: state,
                      context: context,
                      state: state);
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: utilsManagementScreen,
                name: utilsManagementScreen,
                builder: (context, state) {
                  return const UtillsManagementScreen();
                },
                pageBuilder: (context, state) {
                  return CustomPageBuilder.getTransitionPage(
                      child: const UtillsManagementScreen(),
                      settings: state,
                      context: context,
                      state: state);
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: categoryScreen,
                  name: categoryScreen,
                  builder: (context, state) {
                    return const CategoryScreen();
                  },
                  pageBuilder: (context, state) {
                    return CustomPageBuilder.getTransitionPage(
                        child: const CategoryScreen(),
                        settings: state,
                        context: context,
                        state: state);
                  },
                  routes: [
                    GoRoute(
                      path: subCategoryPass,
                      name: subCategoryScreen,
                      builder: (context, state) {
                        nkDevLog(
                            "Path Full : ${state.fullPath} ------- Path : ${state.path}");

                        var categoryId = state.pathParameters['id'].toString();
                        var lavel = num.tryParse(
                                state.pathParameters['lavel'].toString()) ??
                            0;
                        var routeChildPath =
                            state.pathParameters['routeChildPath'].toString();
                        nkDevLog("CHILD PATH : $routeChildPath");
                        return CategoryFolderScreen(
                          categoryId: categoryId,
                          routingState: state,
                          routeChildrenPath: routeChildPath,
                          key: UniqueKey(),
                          lavel: lavel,
                        );
                      },
                      pageBuilder: (context, state) {
                        nkDevLog(
                            "Path Full : ${state.fullPath} ------- Path : ${state.path}");
                        nkDevLog("Path URI : ${state.uri}");
                        nkDevLog("Path Match : ${state.matchedLocation}");
                        var categoryId = state.pathParameters['id'].toString();
                        var lavel = num.tryParse(
                                state.pathParameters['lavel'].toString()) ??
                            0;
                        var routeChildPath =
                            state.pathParameters['routeChildPath'].toString();
                        nkDevLog("CHILD PATH : $routeChildPath");
                        return CustomPageBuilder.getTransitionPage(
                            child: CategoryFolderScreen(
                              key: UniqueKey(),
                              categoryId: categoryId,
                              routingState: state,
                              routeChildrenPath: routeChildPath,
                              lavel: lavel,
                            ),
                            settings: state,
                            context: context,
                            state: state);
                      },
                    ),
                  ]),
            ]),
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
          return null;
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
