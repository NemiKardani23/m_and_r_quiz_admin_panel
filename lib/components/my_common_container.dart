import 'dart:ui';

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
  final double? elevation;
  final Clip? clipBehavior;
  final List<BoxShadow>? boxShadow;

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
      this.clipBehavior,
      this.gradient,
      this.isAnimatedContainer = false,
      this.isCardView = false,
      this.elevation
      ,this.boxShadow});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return isAnimatedContainer == false
        ? isCardView
            ? Card(
                elevation: elevation,
                child: Container(
                  clipBehavior:clipBehavior ?? Clip.antiAlias,
                  width: width,
                  height: height,
                  margin: margin,
                  
                  constraints: boxConstraints,
                  alignment: alignment,
                  decoration: BoxDecoration(
                    boxShadow: boxShadow,
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
                     clipBehavior:clipBehavior ?? Clip.antiAlias,
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
                 clipBehavior:clipBehavior ?? Clip.antiAlias,
                constraints: boxConstraints,
                alignment: alignment,
                decoration: BoxDecoration(
                  boxShadow: boxShadow,
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
                  
                   clipBehavior:clipBehavior ?? Clip.antiAlias,
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
               clipBehavior:clipBehavior ?? Clip.antiAlias,
              height: height,
              margin: margin,
              constraints: boxConstraints,
              alignment: alignment,
              decoration: BoxDecoration(
                boxShadow: boxShadow,
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
                 clipBehavior:clipBehavior ?? Clip.antiAlias,
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
