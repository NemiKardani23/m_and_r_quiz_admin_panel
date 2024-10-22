import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_network/image_network.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/app_dashboard/diloag/add_slider_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/app_dashboard/model/banner_response.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
part '../app_dashboard/widget/slider_widget.dart';

class AppDashboardScreen extends StatefulWidget {
  const AppDashboardScreen({super.key});

  @override
  State<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends State<AppDashboardScreen> {
  DataHandler<List<BannerData>> sliderListData = DataHandler();

  int _hoverIndex = -1;

  @override
  void initState() {
    sliderData;
    super.initState();
  }

  get sliderData {
    sliderListData.startLoading();
    ApiWorker().getBannerList().then(
      (value) {
        if (value != null && value.data.isNotEmpty && value.status == true) {
          setState(() {
            sliderListData.onSuccess(value.data);
          });
        } else {
          sliderListData.onEmpty(value?.message ?? ErrorStrings.noDataFound);
        }
      },
    ).catchError(
      (e) {
        sliderListData.onError(ErrorStrings.oopsSomethingWentWrong);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(context: context, myBody: _body(context));
  }

  Widget _body(BuildContext context) {
    return MyScrollView(
      children: [
        MyRegularText(
          align: TextAlign.start,
          label: appDashboardStr,
          fontSize: NkFontSize.headingFont,
        ),
        _sliderWidget(context),
      ].addSpaceEveryWidget(space: nkRegularSizedBox),
    );
  }

  Widget _sliderWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRegularText(
              label: appDashboardSliderStr,
              fontSize: NkFontSize.mediumFont,
            ),
            FittedBox(
              child: MyThemeButton(
                  padding: 10.horizontal,
                  buttonText: "$addStr $bannerStr",
                  onPressed: () {
                    showAdaptiveDialog(
                        context: context,
                        builder: (builder) {
                          return AddSliderDiloag(
                            onUpdate: (updatedSlider) {
                              if (sliderListData.data != null &&
                                  sliderListData.data!.isNotEmpty) {
                                sliderListData.data?.add(updatedSlider!);
                              } else {
                                sliderListData.onSuccess([updatedSlider!]);
                              }
                            },
                          );
                        }).then(
                      (value) => setState(() {}),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: primaryIconColor,
                  )),
            ),
          ],
        ),
        nkSmallSizedBox,
        _SliderWidget(
          sliderItemList: sliderListData.whenListWidget(
            context: context,
            successBuilder: (p0) {
              return List.generate(p0.length, (index) {
                var data = p0[index];
                return MyCommnonContainer(
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: 16.all.copyWith(left: 32, right: 32),
                  image: DecorationImage(image: NetworkImage(data.imageUrl!)),
                  child: MouseRegion(
                    onEnter: (event) {
                      setState(() {
                        _hoverIndex = index;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        _hoverIndex = -1;
                      });
                    },
                    child: Stack(
                      children: [
                        if (_hoverIndex == index) ...[
                          Positioned.fill(
                            child: Container(
                              color: secondaryColor.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton.outlined(
                                      onPressed: () {
                                        showAdaptiveDialog(
                                            context: context,
                                            builder: (builder) {
                                              return MyDeleteDialog(
                                                appBarTitle:
                                                    "$deleteStr $bannerStr",
                                                onPressed: () async {
                                                  // await FirebaseDeleteFun()
                                                  //     .deleteAppDashboardSlider(
                                                  //         data.sliderId!,
                                                  //         imageUrl: data.image)
                                                  //     .then((value) {
                                                  //   NKToast.success(
                                                  //       title:
                                                  //           "$sliderStr ${SuccessStrings.deletedSuccessfully}");
                                                  //   setState(() {
                                                  //     sliderListData.data
                                                  //         ?.removeAt(index);
                                                  //   });
                                                  // });
                                                },
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: errorColor,
                                      )),
                                  IconButton.outlined(
                                      onPressed: () {
                                        showAdaptiveDialog(
                                            context: context,
                                            builder: (builder) {
                                              return AddSliderDiloag(
                                                sliderListModel: data,
                                                onUpdate: (updatedSlider) {
                                                  if (sliderListData
                                                          .data?.isNotEmpty ??
                                                      false) {
                                                    sliderListData.data
                                                        ?.replaceRange(
                                                            index,
                                                            index + 1,
                                                            [updatedSlider!]);
                                                  }
                                                },
                                              );
                                            }).then(
                                          (value) => setState(() {}),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: primaryIconColor,
                                      )),
                                ],
                              ),
                            ).fadeInAnimation,
                          )
                        ]
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
