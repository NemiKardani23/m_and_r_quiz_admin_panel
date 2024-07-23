import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class MyScrollView extends StatefulWidget {
  final List<Widget>? children;
  final Axis? scrollDirection;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final void Function()? onInit;
  final void Function()? onDispose;
  final ScrollController? scrollController;
  final bool isShowScrollbar;
  const MyScrollView({
    super.key,
    this.children,
    this.scrollDirection,
    this.padding,
    this.onInit,
    this.onDispose,
    this.shrinkWrap = true,
    this.scrollController,
    this.isShowScrollbar = false,
  });

  @override
  State<MyScrollView> createState() => _MyScrollViewState();
}

class _MyScrollViewState extends State<MyScrollView> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController =
        widget.scrollController ?? ScrollController(keepScrollOffset: false);
    super.initState();
  }

  @override
  dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isShowScrollbar) {
      return Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: Stack(
            children: [
              Positioned.fill(
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: widget.shrinkWrap,
                  scrollDirection: widget.scrollDirection ?? Axis.vertical,
                  padding: widget.padding,
                  children: widget.children ?? [],
                ),
              ),
            ],
          ));
    } else {
      return ListView(
        controller: _scrollController,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection ?? Axis.vertical,
        padding: widget.padding,
        children: widget.children ?? [],
      );
    }
  }
}
