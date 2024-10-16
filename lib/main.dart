import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppRoutes.routesData();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    SessionHelper.instance.getLoginData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
       
        return Material(
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => ToastificationConfigProvider(
                    config: const ToastificationConfig(
                      alignment: Alignment.bottomCenter,
                      itemWidth: 440,
                    ),
                    child: child!),
              ),
            ],
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      theme: NkTheme.lightTheme(context),
      routerConfig: AppRoutes.navigator,
    );
  }
}
