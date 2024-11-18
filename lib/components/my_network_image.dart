import 'package:extended_image/extended_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/null_check_oprations.dart';

class MyNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? appWidth;

  final double? appHeight;
  final BoxFit fit;

  final Function()? onTap;

  final Size? progressbarSize;
  final Size? errorWidgetSize;

  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget Function()? errorWidget;
  final Widget Function(ExtendedImageState extendedImageState)? placeholder;

  const MyNetworkImage({
    super.key,
    required this.imageUrl,
    this.appWidth,
    this.appHeight,
    this.fit = BoxFit.cover,
    this.onTap,
    this.imageBuilder,
    this.errorWidget,
    this.placeholder,
    this.progressbarSize,
    this.errorWidgetSize,
  });

  Widget get onLoading => const Center(
        child: NkLoadingWidget(
          radius: 15,
        ),
      );

  Widget get onError => FittedBox(
        child: Image.asset(Assets.assetsIconsPicture),
      );

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return CachedNetworkImage(
  //     imageUrl: imageUrl.contains('https://')
  //         ? imageUrl
  //         : '${ApiConstant().baseUrl}$imageUrl',
  //     fit: fit,
  //     height: appHeight,
  //     width: appWidth,
  //     repeat: ImageRepeat.repeat,
  //     imageBuilder: imageBuilder,
  //     errorWidget: errorWidget ?? (context, url, error) => onError,
  //     placeholder: placeholder,
  //     fadeOutCurve: Curves.fastEaseInToSlowEaseOut,
  //     fadeInCurve: Curves.fastEaseInToSlowEaseOut,
  //     progressIndicatorBuilder: progressIndicatorBuilder ??
  //         (context, url, downloadProgress) {
  //           return NkLoadingWidget.partiallyRevealed(
  //               progress: downloadProgress.progress ?? 0);
  //         },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (imageBuilder != null) {
      if (CheckNullData.checkNullOrEmptyString(imageUrl)) {
        return onError;
      } else {
        return imageBuilder?.call(
                context,
                ExtendedNetworkImageProvider(
                  imageUrl.contains('https://')
                      ? imageUrl
                      : '${ApiConstant().baseUrl}$imageUrl',
                  cache: true,
                  cacheMaxAge: const Duration(days: 1),
                )) ??
            0.space;
      }
    }
    return _networkImage(
        imageUrl.contains('https://')
            ? imageUrl
            : '${ApiConstant().baseUrl}$imageUrl',
        context);
  }

  ExtendedNetworkImageProvider networkImageProvider() {
    return ExtendedNetworkImageProvider(
      imageUrl.contains('https://')
          ? imageUrl
          : '${ApiConstant().baseUrl}$imageUrl',
      cache: true,
      cacheMaxAge: const Duration(days: 1),
    );
  }

  Widget _networkImage(String url, BuildContext context) {
    return SizedBox(
      child: ExtendedImage.network(
        
        url,
        fit: fit,
        scale: 1,
        cache: true,
        height: appHeight,
        borderRadius: NkGeneralSize.nkCommonSmoothBorderRadius,
        width: appWidth,
        // repeat: ImageRepeat.repeat,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return SizedBox(
                  height: progressbarSize?.height,
                  width: progressbarSize?.width,
                  child: const NkLoadingWidget());
            case LoadState.completed:
              return ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                fit: fit,
                height: appHeight,
                width: appWidth,
                scale: 1.0,
                filterQuality: FilterQuality.high,
                repeat: ImageRepeat.repeat,
              );
            case LoadState.failed:
              return errorWidget?.call() ?? onError;
            default:
              return onLoading;
          }
        },
      ),
    );
  }
}
