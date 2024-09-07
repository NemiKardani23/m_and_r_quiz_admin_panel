import 'package:carousel_slider/carousel_slider.dart';
import 'package:m_and_r_quiz_admin_panel/components/animation/common_animation/basic_animation.dart';
import 'package:m_and_r_quiz_admin_panel/components/common_diloag/my_delete_dialog.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_network_image.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_delete_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/app_dashboard/diloag/add_slider_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/model/slider_list_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part '../app_dashboard/widget/slider_widget.dart';

class AppDashboardScreen extends StatefulWidget {
  const AppDashboardScreen({super.key});

  @override
  State<AppDashboardScreen> createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends State<AppDashboardScreen> {
  DataHandler<List<SliderListModel>> sliderListData = DataHandler();

  int _hoverIndex = -1;

  @override
  void initState() {
    sliderData;
    super.initState();
  }

  get sliderData {
    sliderListData.startLoading();
    FirebaseGetFun().getAppDashboardSliderList().then(
      (value) {
        if (value != null && value.isNotEmpty) {
          setState(() {
            sliderListData.onSuccess(value);
          });
        } else {
          setState(() {
            sliderListData.onEmpty(ErrorStrings.noDataFound);
          });
        }
      },
    ).catchError(
      (error) {
        setState(() {
          sliderListData.onError(ErrorStrings.oopsSomethingWentWrong);
        });
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
                  leadingIcon: const Icon(
                    Icons.add,
                    color: secondaryIconColor,
                  ),
                  buttonText: "$addStr $sliderStr",
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
                  }),
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
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: 16.all.copyWith(left: 32, right: 32),
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
                        Positioned.fill(
                          child: _SliderWidget.sliderImageWidgetBuilder(context,
                              imageUrl: data.image ?? ""),
                        ),
                        if (_hoverIndex == index) ...[
                          Positioned.fill(
                            child: Container(
                              color: secondaryColor.withOpacity(0.5),
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
                                                    "$deleteStr $sliderStr",
                                                onPressed: () async {
                                                  await FirebaseDeleteFun()
                                                      .deleteAppDashboardSlider(
                                                          data.sliderId!,
                                                          imageUrl: data.image)
                                                      .then((value) {
                                                    NKToast.success(
                                                        title:
                                                            "$sliderStr ${SuccessStrings.deletedSuccessfully}");
                                                    setState(() {
                                                      sliderListData.data
                                                          ?.removeAt(index);
                                                    });
                                                  });
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
                                        color: secondaryIconColor,
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
