import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/question_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';


class TempDataStore {

  /// !! It's temporary data store for Firebase !!

      
      static ValueNotifier<List<QuestionTypeData>?> questionTypeList =
      ValueNotifier(null);
      
      
  // !! It's temporary data store for API !!
        static ValueNotifier<List<FileTypeData>?> tempFileTypeList =
      ValueNotifier(null);   
      
       static ValueNotifier<List<CategoryTypeData>?> tempCategoryTypeList =
      ValueNotifier(null);


     static Future<List<FileTypeData>?> get getFileTypeList async {
    if (tempFileTypeList.value == null || tempFileTypeList.value?.isEmpty == true) {
      tempFileTypeList.value = await ApiWorker().getFileTypeList().then((value) => value?.data,);
      return tempFileTypeList.value;
    } else {
      return tempFileTypeList.value;
    }
  } 
  
     static Future<List<CategoryTypeData>?> get getCategoryTypeList async {
    if (tempCategoryTypeList.value == null || tempCategoryTypeList.value?.isEmpty == true) {
      tempCategoryTypeList.value = await ApiWorker().getCategoryTypeList().then((value) => value?.data,);
      return tempCategoryTypeList.value;
    } else {
      return tempCategoryTypeList.value;
    }
  }   static Future<List<QuestionTypeData>?> get getQuestionTypeList async {
    if (questionTypeList.value == null || questionTypeList.value?.isEmpty == true) {
      questionTypeList.value = await ApiWorker().getQuestionTypeList().then((value) => value?.data,);
      return questionTypeList.value;
    } else {
      return questionTypeList.value;
    }
  }

   

  // static Future<List<BoardListModel>?> get boardList async {
  //   if (tempBoardList.value == null || tempBoardList.value?.isEmpty == true) {
  //     tempBoardList.value = await FirebaseGetFun().getBordList();
  //     return tempBoardList.value;
  //   } else {
  //     return tempBoardList.value;
  //   }
  // }

  // static Future<List<StandardListModel>?> standardList(String boardId) async {
  //   if (tempStandardList.value == null ||
  //       tempStandardList.value?.isEmpty == true ||
  //       tempStandardList.value?.every((e) => e.boardId == boardId) == false) {
  //     tempStandardList.value = await FirebaseGetFun().getStandardList(boardId);
  //     return tempStandardList.value;
  //   } else {
  //     return tempStandardList.value;
  //   }
  // }

  // static Future<List<SubjectListModel>?> subjectList(
  //     String boardId, String standardId) async {
  //   if (tempSubjectList.value == null ||
  //       tempSubjectList.value?.isEmpty == true ||
  //       tempSubjectList.value?.every(
  //               (e) => e.standardId == standardId && e.boardId == boardId) ==
  //           false) {
  //     tempSubjectList.value =
  //         await FirebaseGetFun().getSubjectList(boardId, standardId);
  //     return tempSubjectList.value;
  //   } else {
  //     return tempSubjectList.value;
  //   }
  // }
  // static Future<List<StudentListModel>?> studentList({bool isRefresh = false}) async {
  //   if (tempStudentList.value == null ||
  //       tempStudentList.value?.isEmpty == true || isRefresh ) {
  //     tempStudentList.value =
  //         await FirebaseGetFun().getStudentList();
  //     return tempStudentList.value;
  //   } else {
  //     return tempStudentList.value;
  //   }
  // }

  //  static Future<int?> get getStudentCount async {
  //   nkDevLog("--------------- GET STUDENT CALLED");
  //   try {
  //     return  FirebaseGetFun().storage.collection(ApiConstant().student).count().get().then((_)=> _.count);
  //   } on FirebaseException catch (e) {
  //     NKToast.error(title: e.message.toString());
  //      return null;
  //   }
  // }
}
