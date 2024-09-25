import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';

class AddCategoryTypeDiloag extends StatefulWidget {
  final CategoryTypeData? categoryTypeModel;
  final Function(CategoryTypeData? type)? onTypeUpdated;
  const AddCategoryTypeDiloag(
      {super.key, this.categoryTypeModel, this.onTypeUpdated});

  @override
  State<AddCategoryTypeDiloag> createState() => _AddCategoryTypeDiloagState();
}

class _AddCategoryTypeDiloagState extends State<AddCategoryTypeDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoryTypeData? _categoryTypeData;

  @override
  void initState() {
    if (widget.categoryTypeModel != null) {
      _categoryTypeData = widget.categoryTypeModel;
      nameController.text = _categoryTypeData?.name??nameController.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: widget.categoryTypeModel != null
            ? "$editStr $categoryTypeStr"
            : "$addStr $categoryTypeStr",
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
            labelText: "$categoryTypeStr $nameStr",
            isShowDefaultValidator: true,
            onChanged: (value) {
              _categoryTypeData = widget.categoryTypeModel?.copyWith(
                name: value,
              );
            },
          ),
          const MyRegularText(label: descriptionStr),
          MyFormField(
            controller: descriptionController,
            labelText: "$categoryTypeStr $descriptionStr",
            isShowDefaultValidator: false,
            isRequire: false,
            onChanged: (value) {
              _categoryTypeData=widget.categoryTypeModel?.copyWith(
                description: value,
              );
            },
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: widget.categoryTypeModel != null
                  ? "$updateStr $categoryTypeStr"
                  : "$addStr $categoryTypeStr",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (widget.categoryTypeModel != null) {
                    await ApiWorker()
                        .updateCategoryType(
                      description: _categoryTypeData?.description??"",
                      id: _categoryTypeData?.id.toString()??"",
                      name: _categoryTypeData?.name??"",
                    )
                        .then(
                      (value) {
                        NKToast.success(
                            description: value?.message ??
                                "$categoryTypeStr ${SuccessStrings.updatedSuccessfully}");
                        widget.onTypeUpdated?.call(null);
                        AppRoutes.navigator.pop();
                      },
                    );
                  } else {
                    await ApiWorker()
                        .addCategoryType(
                      description: descriptionController.text,
                      name: nameController.text,
                    )
                        .then(
                      (value) {
                        NKToast.success(
                            title:
                                "$categoryTypeStr ${SuccessStrings.addedSuccessfully}");
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
