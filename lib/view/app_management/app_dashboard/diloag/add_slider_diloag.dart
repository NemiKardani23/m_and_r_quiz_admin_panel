import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';

import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/utills/image_upload/nk_multipart.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/app_dashboard/model/banner_response.dart';

class AddSliderDiloag extends StatefulWidget {
  final BannerData? sliderListModel;
  final Function(BannerData? updatedSlider)? onUpdate;
  const AddSliderDiloag({super.key, this.sliderListModel, this.onUpdate});

  @override
  State<AddSliderDiloag> createState() => _AddSliderDiloagState();
}

class _AddSliderDiloagState extends State<AddSliderDiloag> {
  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  BannerData? _sliderListModel;

  @override
  void initState() {
    _sliderListModel = widget.sliderListModel;
    loadModelData;
    super.initState();
  }

  get loadModelData {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: _sliderListModel != null
            ? "$editStr $bannerStr"
            : "$addStr $bannerStr",
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: context.isMobile ? context.width : context.width * 0.25),
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: NkPickerWithPlaceHolder(
            pickType: FileType.any,
            imageUrl: _sliderListModel?.imageUrl ?? "",
            fileType: "image",
            onFilePicked: (imageBytes, imageName) {
              onImagePicked = (imageBytes, imageName);
            },
          ),
        ),
        MyThemeButton(
            isLoadingButton: true,
            buttonText: _sliderListModel != null
                ? "$updateStr $bannerStr"
                : "$addStr $bannerStr",
            onPressed: () async {
              if (widget.sliderListModel != null) {
                if (onImagePicked == null) {
                  NKToast.error(
                      title: "$bannerStr ${ErrorStrings.selectImage}");
                  return;
                } else {
                  ApiWorker()
                      .updateBanner(
                          image: NKMultipart.getMultipartFileBytes(
                              fileBytes: onImagePicked!.$1!,
                              name: onImagePicked!.$2!),
                          id: widget.sliderListModel!.id!.toString())
                      .then((data) {
                    if (data != null) {
                      NKToast.success(
                          title:
                              "$bannerStr ${SuccessStrings.updatedSuccessfully}");
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      widget.onUpdate?.call(data);
                    }
                  });
                }
              } else {
                if (onImagePicked == null) {
                  NKToast.error(
                      title: "$bannerStr ${ErrorStrings.selectImage}");
                  return;
                } else {
                  ApiWorker()
                      .addBanner(
                          image: NKMultipart.getMultipartFileBytes(
                              fileBytes: onImagePicked!.$1!,
                              name: onImagePicked!.$2!))
                      .then((data) {
                    if (data != null && data.status == true) {
                      NKToast.success(
                          title:
                              "$bannerStr ${SuccessStrings.addedSuccessfully}");
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      widget.onUpdate?.call(null);
                    }
                  });
                }

                //  await FirebaseAddFun().addAppDashboardSlider(
                //       sliderData: sliderData,
                //       image: onImagePicked!.$1,
                //       filename: onImagePicked!.$2).then((data) {
                //             if (data != null) {
                //     NKToast.success(
                //         title: "$sliderStr ${SuccessStrings.addedSuccessfully}");
                //             Navigator.pop(context);
                //     widget.onUpdate?.call(data);
                //   }
                //       },);
              }
            })
      ].addSpaceEveryWidget(space: nkSmallSizedBox),
    );
  }
}
