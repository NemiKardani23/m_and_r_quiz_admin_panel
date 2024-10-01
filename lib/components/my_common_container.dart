import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class MyCommnonContainer extends StatelessWidget {
  final Widget? child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;

  final Color? color;
  final DecorationImage? image;
  final BoxBorder? border;
  final BoxShape? boxShape;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool isCommonBorder;
  final bool isShowError;
  final bool isAnimatedContainer;
  final BoxConstraints? boxConstraints;
  final AlignmentGeometry? alignment;
  final Color? inkwellSplashColor;
  final BorderRadius? borderRadiusGeometry;
  final Gradient? gradient;
  final bool isCardView;

  const MyCommnonContainer(
      {super.key,
      this.child,
      this.onTap,
      this.onDoubleTap,
      this.color,
      this.image,
      this.border,
      this.boxShape,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.boxConstraints,
      this.alignment,
      this.inkwellSplashColor,
      this.borderRadiusGeometry,
      this.isCommonBorder = false,
      this.isShowError = false,
      this.gradient,
      this.isAnimatedContainer = false,
      this.isCardView = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return isAnimatedContainer == false
        ? isCardView
            ? Card(
                child: Container(
                  width: width,
                  height: height,
                  margin: margin,
                  constraints: boxConstraints,
                  alignment: alignment,
                  decoration: BoxDecoration(
                    color: color ?? theme.colorScheme.primaryContainer,
                    shape: boxShape ?? BoxShape.rectangle,
                    gradient: gradient,
                    image: image,
                    border: isCommonBorder || isShowError
                        ? Border.all(
                            color: !isShowError
                                ? primaryTextFieldColor
                                : errorColor)
                        : border,
                    borderRadius: borderRadiusGeometry ??
                        NkGeneralSize.nkCommonBorderRadius,
                  ),
                  child: Material(
                    color: transparent,
                    child: InkWell(
                      splashColor: inkwellSplashColor,
                      highlightColor: inkwellSplashColor,
                      borderRadius: borderRadiusGeometry ??
                          NkGeneralSize.nkCommonBorderRadius,
                      onTap: onTap,
                      onDoubleTap: onDoubleTap,
                      child: Padding(
                        padding: padding ?? EdgeInsets.zero,
                        child: child,
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                width: width,
                height: height,
                margin: margin,
                constraints: boxConstraints,
                alignment: alignment,
                decoration: BoxDecoration(
                  color: color ?? theme.colorScheme.primaryContainer,
                  shape: boxShape ?? BoxShape.rectangle,
                  gradient: gradient,
                  image: image,
                  border: isCommonBorder || isShowError
                      ? Border.all(
                          color:
                              !isShowError ? primaryTextFieldColor : errorColor)
                      : border,
                  borderRadius: borderRadiusGeometry ??
                      NkGeneralSize.nkCommonBorderRadius,
                ),
                child: Material(
                  color: transparent,
                  child: InkWell(
                    splashColor: inkwellSplashColor,
                    highlightColor: inkwellSplashColor,
                    borderRadius: borderRadiusGeometry ??
                        NkGeneralSize.nkCommonBorderRadius,
                    onTap: onTap,
                    child: Padding(
                      padding: padding ?? EdgeInsets.zero,
                      child: child,
                    ),
                  ),
                ),
              )
        : AnimatedSize(
            duration: NkGeneralSize.nkCommonLongDuration,
            curve: Curves.easeInOutCubicEmphasized,
            child: Container(
              width: width,
              height: height,
              margin: margin,
              constraints: boxConstraints,
              alignment: alignment,
              decoration: BoxDecoration(
                color: color ?? theme.colorScheme.primaryContainer,
                shape: boxShape ?? BoxShape.rectangle,
                gradient: gradient,
                image: image,
                border: isCommonBorder || isShowError
                    ? Border.all(
                        color:
                            !isShowError ? primaryTextFieldColor : errorColor)
                    : border,
                borderRadius:
                    borderRadiusGeometry ?? NkGeneralSize.nkCommonBorderRadius,
              ),
              child: Material(
                color: transparent,
                child: InkWell(
                  splashColor: inkwellSplashColor,
                  highlightColor: inkwellSplashColor,
                  borderRadius: borderRadiusGeometry ??
                      NkGeneralSize.nkCommonBorderRadius,
                  onTap: onTap,
                  child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: child,
                  ),
                ),
              ),
            ),
          );
  }
}
