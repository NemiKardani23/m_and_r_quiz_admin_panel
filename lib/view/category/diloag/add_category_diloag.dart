import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/widget/add_file_widget.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/widget/add_folder_widget.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

enum CategoryTypeENUM { folder, image, video,pdf,document,audio,ePublisher }

extension CategoryTypeExtension on CategoryTypeENUM {
  String get categoryType {
    switch (this) {
      case CategoryTypeENUM.folder:
        return "FOLDER";
      case CategoryTypeENUM.image:
        return "IMAGE";
      case CategoryTypeENUM.video:
        return "VIDEO";
      case CategoryTypeENUM.pdf:
        return "PDF";
      case CategoryTypeENUM.document:
        return "DOCUMENT";
      case CategoryTypeENUM.audio:
        return "AUDIO";
      case CategoryTypeENUM.ePublisher:
        return "EPUB";
    }
  }
}

CategoryTypeENUM convertStringToCategoryType(String str) {
  switch (str) {
    case "FOLDER":
      return CategoryTypeENUM.folder;
    case "IMAGE":
      return CategoryTypeENUM.image;
    case "VIDEO":
      return CategoryTypeENUM.video;
    case "PDF":
      return CategoryTypeENUM.pdf;
    case "DOCUMENT":
      return CategoryTypeENUM.document;
    case "AUDIO":
      return CategoryTypeENUM.audio;
    case "EPUB":
      return CategoryTypeENUM.ePublisher;
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
  const AddCategoryDiloag(
      {super.key,
      this.categoryDataModel,
      this.onUpdated,
      required this.categoryType, required this.fileTypeModel, required this.parentId,});

  @override
  Widget build(BuildContext context) {
    switch (categoryType) {
      case CategoryTypeENUM.folder:
        return AddFolderDiloagWidget(
          parentId:  parentId,
          fileTypeModel:  fileTypeModel,
          categoryDataModel: categoryDataModel,
         
      
          onUpdated: onUpdated,
        );

      case CategoryTypeENUM.image:
        return AddFileDiloag(
          categoryDataModel: categoryDataModel,
      
          onUpdated: onUpdated, fileTypeModel: fileTypeModel,
        );
      default:
        return const NkEmptyWidget();
    }
  }
}
