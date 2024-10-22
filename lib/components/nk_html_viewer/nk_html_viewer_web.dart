import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:fwfh_chewie/fwfh_chewie.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';





import 'dart:convert';

import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkHtmlViewerWEB extends StatelessWidget {
  final String htmlContent;
  const NkHtmlViewerWEB({required this.htmlContent, super.key});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      htmlContent,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      factoryBuilder: () => NkHtmlViewerWEBFactory(), // Custom factory for rendering
      customWidgetBuilder: (element) {
        if (element.localName == 'img' &&
            element.attributes['src'] != null &&
            element.attributes['src']?.contains('http') == true) {
          return MyNetworkImage(
            imageUrl: element.attributes['src'] ?? "",
            appHeight: (context.size?.longestSide ?? 0) * 0.2,
            appWidth: (context.size?.longestSide ?? 0) * 0.2,
          );
        } else if (element.localName == 'img' &&
            element.attributes['src'] != null &&
            element.attributes['src']?.contains('base64') == false) {
          return Image.memory(
            base64Decode(element.attributes['src'] ?? ""),
            height: 100,
            width: 100,
          );
        }
        return null;
      },
      renderMode: RenderMode.column,
    );
  }
}

class NkHtmlViewerWEBFactory extends WidgetFactory with ChewieFactory,CachedNetworkImageFactory,UrlLauncherFactory      {


}