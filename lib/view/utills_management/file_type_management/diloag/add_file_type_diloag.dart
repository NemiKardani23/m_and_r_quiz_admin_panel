import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

class AddFileTypeDiloag extends StatefulWidget {
  final FileTypeData? fileTypeModel;
  final Function(CategoryTypeData? type)? onTypeUpdated;
  const AddFileTypeDiloag(
      {super.key, this.fileTypeModel, this.onTypeUpdated});

  @override
  State<AddFileTypeDiloag> createState() => _AddFileTypeDiloagState();
}

class _AddFileTypeDiloagState extends State<AddFileTypeDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FileTypeData? _fileTypeData;

  @override
  void initState() {
    if (widget.fileTypeModel != null) {
      _fileTypeData = widget.fileTypeModel;
      nameController.text = _fileTypeData?.typeName??nameController.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: widget.fileTypeModel != null
            ? "$editStr $fileTypeStr"
            : "$addStr $fileTypeStr",
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
          const MyRegularText(label: nameStr),
          MyFormField(
            controller: nameController,
            labelText: "$fileTypeStr $nameStr",
            isShowDefaultValidator: true,
            onChanged: (value) {
              _fileTypeData = widget.fileTypeModel?.copyWith(
                typeName: value,
              );
            },
          ),
          const MyRegularText(label: descriptionStr),
          MyFormField(
            controller: descriptionController,
            labelText: "$fileTypeStr $descriptionStr",
            isShowDefaultValidator: false,
            isRequire: false,
            onChanged: (value) {
              _fileTypeData=widget.fileTypeModel?.copyWith(
                description: value,
              );
            },
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: widget.fileTypeModel != null
                  ? "$updateStr $fileTypeStr"
                  : "$addStr $fileTypeStr",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (widget.fileTypeModel != null) {
                    await ApiWorker()
                        .updateFileType(
                      description: _fileTypeData?.description??"",
                      id: _fileTypeData?.id.toString()??"",
                      name: _fileTypeData?.typeName??"",
                    )
                        .then(
                      (value) {
                        NKToast.success(
                            description: value?.message ??
                                "$fileTypeStr ${SuccessStrings.updatedSuccessfully}");
                        widget.onTypeUpdated?.call(null);
                        AppRoutes.navigator.pop();
                      },
                    );
                  } else {
                    await ApiWorker()
                        .addFileType(
                      description: descriptionController.text,
                      name: nameController.text,
                    )
                        .then(
                      (value) {
                        NKToast.success(
                            title:
                                "$fileTypeStr ${SuccessStrings.addedSuccessfully}");
                        Navigator.pop(context);
                        widget.onTypeUpdated?.call(null);
                      },
                    );
                  }
                }
              })
        ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
      ),
    );
  }
}
