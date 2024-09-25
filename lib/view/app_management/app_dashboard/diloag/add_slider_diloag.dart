import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/components/widget/media_type_option_select_widget.dart';
import 'package:m_and_r_quiz_admin_panel/components/widget/slide_mode_option_select_widget.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_add_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_edit_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/model/slider_list_model.dart';

class AddSliderDiloag extends StatefulWidget {
  final SliderListModel? sliderListModel;
  final Function(SliderListModel? updatedSlider)? onUpdate;
  const AddSliderDiloag({super.key, this.sliderListModel, this.onUpdate});

  @override
  State<AddSliderDiloag> createState() => _AddSliderDiloagState();
}

class _AddSliderDiloagState extends State<AddSliderDiloag> {
  String? selectedMediaType = "Image";
  String? selectedModeType = "Normal";
  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  SliderListModel? _sliderListModel;

  @override
  void initState() {
    _sliderListModel = widget.sliderListModel;
    loadModelData;
    super.initState();
  }

  get loadModelData {
    selectedMediaType =
        _sliderListModel?.sliderContentType ?? selectedMediaType;
    selectedModeType = _sliderListModel?.sliderMode ?? selectedModeType;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: _sliderListModel != null
            ? "$editStr $sliderStr"
            : "$addStr $sliderStr",
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
            imageUrl: _sliderListModel?.image ?? "",
            fileType: selectedMediaType?.toLowerCase() ?? "",
            onFilePicked: (imageBytes, imageName) {
              onImagePicked = (imageBytes, imageName);
            },
          ),
        ),
        _selectMediaType(context),
        _selectMode(context),
        MyThemeButton(
            isLoadingButton: true,
            buttonText: _sliderListModel != null
                ? "$updateStr $sliderStr"
                : "$addStr $sliderStr",
            onPressed: () async {
              if (widget.sliderListModel != null) {
                // await FirebaseEditFun().editAppDashboardSlider(
                //     sliderData: _sliderListModel!,
                //     image: onImagePicked?.$1,
                //     filename: onImagePicked?.$2).then((data) {
                //         if (data != null) {
                //   NKToast.success(
                //       title:
                //           "$sliderStr ${SuccessStrings.updatedSuccessfully}");
                //               Navigator.pop(context);
                //   widget.onUpdate?.call(data);
                // }
                //     },);
              
              } else {
                if (onImagePicked == null) {
                  NKToast.error(
                      title: "$sliderStr ${ErrorStrings.selectImage}");
                  return;
                }
                SliderListModel sliderData = SliderListModel(
                  sliderContentType: selectedMediaType,
                  sliderMode: selectedModeType,
                );
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

  Widget _selectMediaType(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyRegularText(label: "$selectStr $mediaTypeStr"),
        nkExtraSmallSizedBox,
        MediaTypeOptionSelectWidget(
          value: selectedMediaType,
          onValueChanged: (p0) {
            if (_sliderListModel != null) {
              _sliderListModel!.sliderContentType = p0;
            }
            setState(() {
              selectedMediaType = p0;
            });
          },
        ),
      ],
    );
  }

  Widget _selectMode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyRegularText(label: "$selectStr $modeTypeStr"),
        nkExtraSmallSizedBox,
        SlideOptionSelectWidget(
          value: selectedModeType,
          onValueChanged: (p0) {
            if (_sliderListModel != null) {
              _sliderListModel!.sliderMode = p0;
            }
            setState(() {
              selectedModeType = p0;
            });
          },
        ),
      ],
    );
  }
}
