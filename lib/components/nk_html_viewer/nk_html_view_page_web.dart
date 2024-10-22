import 'dart:html' as html;
import 'dart:ui_web' as ui; // Only for web platform
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkHtmlViewPageWeb extends StatefulWidget {
  final String htmlData;
  final Function(html.MessageEvent? event)? onTap;

  const NkHtmlViewPageWeb({super.key, required this.htmlData, this.onTap});

  @override
  State<NkHtmlViewPageWeb> createState() => _NkHtmlViewPageWebState();
}

class _NkHtmlViewPageWebState extends State<NkHtmlViewPageWeb> {
  @override
  void initState() {
    super.initState();

    html.window.onMessage.listen((event) {
      widget.onTap?.call(event);
      // Check if the message matches what was sent from the HTML page
      nkDevLog("EVENT DATA : ${event.data}");
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // Register the view type for the IFrame
    return webViewPlatformWebsite(
        webviewId: 1,
        code: widget.htmlData, // This is the HTML code passed dynamically
        width: context.width,
        height: context.height);
  }

  Widget webViewPlatformWebsite(
      {required int webviewId,
      required String code,
      required double width,
      required double height}) {
    // html.window.onMessage.listen((event) {
    //   if (event.data == 'goToHome') {
    //     // Handle the event - navigate to home or perform any other action
    //     AppRoutes.navigator.goNamed(
    //         AppRoutes.dashboardScreen); // Example: navigation to home
    //   }
    // });
    // Create an IFrame element and dynamically inject the HTML content.
    html.IFrameElement iframeElement = html.IFrameElement()
      ..srcdoc = code // Use `srcdoc` to inject custom HTML
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..onLoad.listen((event) {
        print('IFrame loaded');
      });

    String webviewRegisterKey = "webpage${UniqueKey().toString()}";

    // Register the IFrame with Flutter's web platform view
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      webviewRegisterKey,
      (int viewId) => iframeElement,
    );

    // Return the HtmlElementView which contains the IFrame
    return SizedBox(
        width: width,
        height: height,
        child: HtmlElementView(viewType: webviewRegisterKey));
  }
}
