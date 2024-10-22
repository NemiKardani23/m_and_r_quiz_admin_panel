part of '../app_dashboard_screen.dart';

class _SliderWidget extends StatefulWidget {
  final CarouselSliderController? carouselController;
  final List<Widget> sliderItemList;
  const _SliderWidget({this.carouselController, required this.sliderItemList});

  @override
  State<_SliderWidget> createState() => _SliderWidgetState();

  static Widget sliderImageWidgetBuilder(
    BuildContext context, {
    required String imageUrl,
  }) {
    return Center(
      child: MyNetworkImage(
        appWidth: double.maxFinite,
        appHeight: double.maxFinite,
        imageUrl: imageUrl,
      ),
    );
  }
}

class _SliderWidgetState extends State<_SliderWidget> {
  int _current = 0;
  CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  void initState() {
    if (widget.carouselController != null) {
      _carouselSliderController = widget.carouselController!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.sliderItemList,
          carouselController: _carouselSliderController,
          options: CarouselOptions(
              height: context.height * 0.33,
              autoPlay: false,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              viewportFraction: context.isDesktop ? 0.28 : 1.0,
              clipBehavior: Clip.antiAlias,
              // aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filled(
                onPressed: () {
                  _carouselSliderController.previousPage();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            Wrap(
              children: [
                AnimatedSmoothIndicator(
                  activeIndex: _current,
                  count: widget.sliderItemList.length,
                  effect:  ScrollingDotsEffect(
                    activeDotColor: selectionColor,
                    dotColor: grey.withOpacity(0.2),
                  ),
                ),
                MyRegularText(
                    label: " ${_current + 1}/ ${widget.sliderItemList.length}"),
              ],
            ),
            IconButton.filled(
                onPressed: () {
                  _carouselSliderController.nextPage();
                },
                icon: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ],
    );
  }
}
