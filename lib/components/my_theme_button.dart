import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class MyThemeButton extends StatefulWidget {
  final String? buttonText;
  final Function()? onPressed;
  final Color? color;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final double? letterSpacing;
  final Widget? child;
  final Widget? leadingIcon;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? padding;
  final bool isLoadingButton;

  const MyThemeButton({
    super.key,
    @required this.buttonText,
    this.color = primaryButtonColor,
    this.onPressed,
    this.fontSize,
    this.height,
    this.width,
    this.child,
    this.padding,
    this.letterSpacing,
    this.shape,
    this.fontColor = buttonTextColor,
    this.isLoadingButton = false,
    this.fontWeight,
    this.leadingIcon,
  });

  @override
  State<MyThemeButton> createState() => _MyThemeButtonState();
}

class _MyThemeButtonState extends State<MyThemeButton> {
  bool isLoading = false;

  Future<void> _asyncButtonWithLoader() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Future.delayed(NkGeneralSize.nkCommonDuration, () async {
        await widget.onPressed?.call();
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MaterialButton(
      height: widget.height ?? 40.0,
      minWidth: widget.width,
      onPressed:
          widget.isLoadingButton ? _asyncButtonWithLoader : widget.onPressed,
      textTheme: theme.buttonTheme.textTheme,
      shape: widget.shape ??
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
      padding: 0.all,
      color: widget.color ?? theme.buttonTheme.colorScheme?.background,
      /* focusColor: color ??
                theme.buttonTheme.colorScheme?.background.withOpacity(0.7),*/
      disabledColor: widget.color,
      child: SizedBox(
        width: widget.width,
        height: widget.height ?? 40.0,
        child: Center(
          child: Padding(
            padding: widget.padding ?? 0.all,
            child: isLoading
                ? const NkLoadingWidget()
                : widget.child ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.leadingIcon != null) ...[
                          widget.leadingIcon!
                        ],
                        MyRegularText(
                          fontWeight: widget.fontWeight,
                          label: widget.buttonText ?? "ADD NAME !!!!",
                          color: widget.fontColor,
                          fontSize: widget.fontSize ?? NkFontSize.regularFont,
                          letterSpacing: widget.letterSpacing,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
