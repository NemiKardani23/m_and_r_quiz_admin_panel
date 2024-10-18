import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_create_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/quiz/quiz_add_form_widget.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/widget/add_document_widget.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/widget/add_folder_widget.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

enum CategoryTypeENUM { folder, document, ePublisher, exam }

extension CategoryTypeExtension on CategoryTypeENUM {
  String get categoryType {
    switch (this) {
      case CategoryTypeENUM.folder:
        return "FOLDER";
      case CategoryTypeENUM.document:
        return "DOCUMENT";
      case CategoryTypeENUM.ePublisher:
        return "EPUB";
      case CategoryTypeENUM.exam:
        return "EXAM";
      default:
        return "FOLDER";
    }
  }
}

CategoryTypeENUM convertStringToCategoryType(String str) {
  switch (str.toUpperCase()) {
    case "FOLDER":
      return CategoryTypeENUM.folder;
    case "DOCUMENT":
      return CategoryTypeENUM.document;
    case "EPUB":
      return CategoryTypeENUM.ePublisher;
    case "EXAM":
      return CategoryTypeENUM.exam;
    default:
      return CategoryTypeENUM.folder;
  }
}

class AddCategoryDiloag extends StatelessWidget {
  final CategoryData? categoryDataModel;
  final Function(CategoryData? catData)? onUpdated;
  final CategoryTypeENUM categoryType;
  final FileTypeData fileTypeModel;
  final String? parentId;
   final QuizCreateData? quizCreateData; // FOR QUIZ
  const AddCategoryDiloag({
    super.key,
    this.categoryDataModel,
    this.onUpdated,
    required this.categoryType,
    required this.fileTypeModel,
    required this.parentId, this.quizCreateData,
  });

  @override
  Widget build(BuildContext context) {
    switch (categoryType) {
      case CategoryTypeENUM.folder:
        return AddFolderDiloagWidget(
          parentId: parentId,
          fileTypeModel: fileTypeModel,
          categoryDataModel: categoryDataModel,
          onUpdated: onUpdated,
        );

      case CategoryTypeENUM.document:
        return AddDocumentDiloag(
          categoryDataModel: categoryDataModel,
          onUpdated: onUpdated,
          fileTypeModel: fileTypeModel,
          parentId: parentId,
        );
      case CategoryTypeENUM.exam:
        return QuizAddFormWidget(
          quizCreateData:  quizCreateData,
          categoryDataModel: categoryDataModel,
          onUpdated: onUpdated,
          fileTypeModel: fileTypeModel,
          parentId: parentId,
          categoryType: categoryType,
        );
      default:
        return const NkEmptyWidget();
    }
  }
}
