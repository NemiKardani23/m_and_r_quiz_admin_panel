import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';

class CategoryTypeOptionSelectWidget extends StatefulWidget {
  final void Function(CategoryTypeData? categoryType)? onValueChanged;
  final CategoryTypeData? value;
  const CategoryTypeOptionSelectWidget(
      {super.key, this.onValueChanged, this.value});

  @override
  State<CategoryTypeOptionSelectWidget> createState() =>
      _CategoryTypeOptionSelectWidgetState();
}

class _CategoryTypeOptionSelectWidgetState
    extends State<CategoryTypeOptionSelectWidget> {
  DataHandler<List<CategoryTypeData>> categoryTypeDataHandler = DataHandler();
  CategoryTypeData? selectedCategoryType;

  @override
  void initState() {
    if (widget.value != null) {
      selectedCategoryType = widget.value;
    }
    getMediaTypeData();
    super.initState();
  }

  void getMediaTypeData() async {
    TempDataStore.getCategoryTypeList.then(
      (value) {
        if (value != null) {
          setState(() {
            categoryTypeDataHandler.onSuccess(value);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return categoryTypeDataHandler.when(
        context: context,
        successBuilder: (categoryTypeList) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            direction: Axis.horizontal,
            children: List.generate(
              categoryTypeList.length,
              (index) {
                var isSelected =
                    selectedCategoryType?.id == categoryTypeList[index].id;
                return Chip(
                    deleteButtonTooltipMessage:
                        isSelected ? "Selected" : "Select",
                    deleteIcon: isSelected
                        ? const Icon(Icons.check)
                        : Icon(
                            Icons.circle_outlined,
                            color: primaryIconColor.withOpacity(.5),
                          ),
                    onDeleted: () {
                      setState(() {
                        selectedCategoryType = categoryTypeList[index];
                      });
                      widget.onValueChanged?.call(selectedCategoryType);
                    },
                    elevation: isSelected ? NkGeneralSize.nkCommoElevation : 0,
                    color: isSelected
                        ? WidgetStatePropertyAll(selectionColor.withOpacity(.8))
                        : WidgetStatePropertyAll(grey.withOpacity(.2)),
                    label: MyRegularText(
                      label: categoryTypeList[index].name,
                      fontSize: NkFontSize.smallFont,
                    ));
              },
            ),
          );
        });
  }
}
