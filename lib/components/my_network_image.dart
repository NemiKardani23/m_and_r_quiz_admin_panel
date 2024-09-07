import 'package:flutter/cupertino.dart';
import 'package:image_network/image_network.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class MyNetworkImage extends ImageNetwork {
  final String url;
  final double? appWidth;

  final double? appHeight;
  final BoxFit? fit;
  final BoxFitWeb? appFitWeb;
  final Function()? onTap;

  const MyNetworkImage({
    super.key,
    required this.url,
    this.appWidth,
    this.appHeight,
    this.fit,
    this.appFitWeb,
    this.onTap,
  }) : super(
            image: url,
            width: appWidth ?? 50,
            height: appHeight ?? 50,
            fitAndroidIos: fit ?? BoxFit.cover,
            fitWeb: appFitWeb ?? BoxFitWeb.cover,
            onTap: onTap,
            fullScreen: true);

  @override
  // TODO: implement onLoading
  Widget get onLoading => const Center(
        child: CupertinoActivityIndicator(
          radius: 15,
          color: selectionColor,
        ),
      );

  @override
  // TODO: implement onError
  Widget get onError => const Icon(
        Icons.error,
        color: errorColor,
      );
}
