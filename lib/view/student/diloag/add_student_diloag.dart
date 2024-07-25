import 'package:country_code_picker/country_code_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/diloag/state_city_dilaog.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_enable_disable_widget.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/api/state_city_api.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_add_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_edit_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/student/model/student_list_model.dart';

class AddStudentDiloag extends StatefulWidget {
  final StudentListModel? studentListModel;
  final List<BoardListModel> boardList;
  final Function(StudentListModel? student)? onUpdated;
  const AddStudentDiloag({
    super.key,
    this.studentListModel,
    this.onUpdated,
    required this.boardList,
  });

  @override
  State<AddStudentDiloag> createState() => _AddStudentDiloagState();
}

class _AddStudentDiloagState extends State<AddStudentDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final DataHandler<List<StandardListModel>> standardList = DataHandler();

  BoardListModel? newSelectedBoard;
  StandardListModel? newSelectedStandard;
  CountryCode? newSelectedCountryCode = CountryCode(
    dialCode: "+91",
    name: "India",
  );
  StateModel? newSelectedState;
  CityModel? newSelectedCity;
  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  getStandardData(String boardId) async {
    setState(() {
      standardList.startLoading();
    });
    TempDataStore.standardList(boardId).then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          standardList.onSuccess(value);
        });
      } else {
        setState(() {
          standardList.onEmpty(ErrorStrings.noDataFound);
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        standardList.onError(error.toString());
      });
    });
  }

  @override
  void initState() {
    if (widget.studentListModel != null) {
      studentNameController.text = widget.studentListModel!.studentName ?? "";
      numberController.text = widget.studentListModel!.studentNumber ?? "";
      newSelectedCountryCode = CountryCode(
        dialCode: widget.studentListModel!.numberCountryCode ?? "+91",
      );
      newSelectedState = StateModel(
        stateName: widget.studentListModel!.studentState ?? "",
      );
      newSelectedCity = CityModel(
        districtName: widget.studentListModel!.studentCity ?? "",
      );
      loadDropDownData();
    }
    super.initState();
  }

  loadDropDownData() {
    getStandardData(widget.studentListModel?.boardId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: widget.studentListModel != null
            ? "$editStr $studentStr"
            : "$addStr $studentStr",
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: context.isMobile ? context.width : context.width * 0.35),
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: NkImagePickerWithPlaceHolder(
              imageUrl: widget.studentListModel?.image ?? "",
              onImagePicked: (imageBytes, imageName) {
                onImagePicked = (imageBytes, imageName);
              },
            ),
          ),
          const MyRegularText(label: boardStr),
          NkSearchableDropDownMenu<BoardListModel>(
            hintText: "$selectStr $boardStr",
            initialSelection: widget.boardList.firstWhere(
              (element) =>
                  element.boardId
                      ?.contains(widget.studentListModel?.boardId ?? "0ojhj") ??
                  false,
              orElse: () => BoardListModel(),
            ),
            onSelected: (p0) {
              newSelectedBoard = p0;
              if (widget.studentListModel != null) {
                widget.studentListModel?.boardId = p0?.boardId;
              }
              if (p0 != null) {
                getStandardData(p0.boardId!);
              }
            },
            dropdownMenuEntries: List.generate(
                widget.boardList.length,
                (index) => DropdownMenuEntry<BoardListModel>(
                      value: widget.boardList[index],
                      label: widget.boardList[index].boardName ?? "",
                    )),
          ),
          const MyRegularText(label: standardStr),
          standardList.when(
              context: context,
              successBuilder: (standardList) {
                return NkEnableDisableWidget(
                  isEnable: standardList.isNotEmpty,
                  child: NkSearchableDropDownMenu<StandardListModel>(
                    initialSelection: standardList.firstWhere(
                      (element) =>
                          element.standardId ==
                          widget.studentListModel?.standardId,
                      orElse: () => StandardListModel(),
                    ),
                    hintText: "$selectStr $standardStr",
                    onSelected: (val) {
                      newSelectedStandard = val;
                      if (widget.studentListModel != null) {
                        widget.studentListModel?.standardId = val?.standardId;
                      }
                    },
                    dropdownMenuEntries: List.generate(
                        standardList.length,
                        (index) => DropdownMenuEntry<StandardListModel>(
                              value: standardList[index],
                              label: standardList[index].standardName ?? "",
                            )),
                  ),
                );
              }),
          const MyRegularText(label: "$studentStr $nameStr"),
          MyFormField(
            controller: studentNameController,
            labelText: "$addStr $studentStr $nameStr",
            isShowDefaultValidator: true,
            onChanged: (value) {
              widget.studentListModel?.studentName = value;
            },
          ),
          const MyRegularText(label: "$studentStr $numberStr"),
          MyFormField(
            controller: numberController,
            labelText: "$addStr $studentStr $numberStr",
            prefixIconUnderLine: NkCommonFunction.selectCountryCode(
                initialSelection: newSelectedCountryCode?.dialCode,
                onChanged: (p0) {
                  newSelectedCountryCode = p0;
                  if (widget.studentListModel != null) {
                    widget.studentListModel?.numberCountryCode = p0.dialCode;
                  }
                },
                context: context),
            isShowDefaultValidator: true,
            onChanged: (value) {
              widget.studentListModel?.studentNumber = value;
            },
          ),
          const MyRegularText(label: "$studentStr $stateStr"),
          showStateDialog(
            context,
            selectedState: newSelectedState?.stateName,
            onTap: (state) {
              setState(() {
                newSelectedState = state;
              });
              if (widget.studentListModel != null) {
                widget.studentListModel?.studentState = state?.stateName;
              }
            },
          ),
          const MyRegularText(label: "$studentStr $cityStr"),
          NkEnableDisableWidget(
            isEnable: newSelectedState != null,
            child: showCityDialog(
              context,
              selectedCity: newSelectedCity?.districtName,
              onTap: (city) {
                setState(() {
                  newSelectedCity = city;
                });
                if (widget.studentListModel != null) {
                  widget.studentListModel?.studentState = city?.districtName;
                }
              },
              state: newSelectedState?.stateName ?? "",
            ),
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: widget.studentListModel != null
                  ? "$updateStr $studentStr"
                  : "$addStr $studentStr",
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    if (widget.studentListModel != null) {
                      await FirebaseEditFun()
                          .editStudent(
                        image: onImagePicked?.$1,
                        filename: onImagePicked?.$2,
                        studentId: widget.studentListModel!.standardId!,
                        studentModel: widget.studentListModel!,
                      )
                          .then(
                        (value) {
                          NKToast.success(
                              title:
                                  "$boardStr ${SuccessStrings.addedSuccessfully}");
                          Navigator.pop(context);
                          widget.onUpdated?.call(value);
                        },
                      );
                    } else {
                      if (newSelectedBoard != null &&
                          newSelectedStandard != null &&
                          newSelectedCountryCode != null &&
                          newSelectedState != null &&
                          newSelectedCity != null) {
                        await FirebaseAddFun()
                            .addStudent(
                                standardId: newSelectedStandard!.standardId!,
                                boardId: newSelectedBoard!.boardId!,
                                image: onImagePicked?.$1,
                                filename: onImagePicked?.$2,
                                studentName: studentNameController.text,
                                studentNumber: numberController.text,
                                numberCountryCode:
                                    newSelectedCountryCode!.dialCode!,
                                studentCity:
                                    newSelectedCity?.districtName ?? "",
                                studentState: newSelectedState?.stateName ?? "")
                            .then(
                          (value) {
                            NKToast.success(
                                title:
                                    "$boardStr ${SuccessStrings.addedSuccessfully}");

                            widget.onUpdated?.call(value);
                          },
                        );
                      } else if (newSelectedBoard == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $boardStr");
                      } else if (newSelectedStandard == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $standardStr");
                      } else if (newSelectedState == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $stateStr");
                      } else if (newSelectedCity == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $cityStr");
                      }
                    }
                  }
                } on Exception catch (e) {
                  nkDevLog("ADD STANDARD ERROR : ${e.toString()}");
                }
              })
        ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
      ),
    );
  }
}
