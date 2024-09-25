import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';

class TempDataStore {
  static ValueNotifier<List<BoardListModel>?> tempBoardList =
      ValueNotifier(null);
  static ValueNotifier<List<StandardListModel>?> tempStandardList =
      ValueNotifier(null);
  static ValueNotifier<List<SubjectListModel>?> tempSubjectList =
      ValueNotifier(null);

  static Future<List<BoardListModel>?> get boardList async {
    if (tempBoardList.value == null || tempBoardList.value?.isEmpty == true) {
      tempBoardList.value = await FirebaseGetFun().getBordList();
      return tempBoardList.value;
    } else {
      return tempBoardList.value;
    }
  }

  static Future<List<StandardListModel>?> standardList(String boardId) async {
    if (tempStandardList.value == null ||
        tempStandardList.value?.isEmpty == true ||
        tempStandardList.value?.every((e) => e.boardId == boardId) == false) {
      tempStandardList.value = await FirebaseGetFun().getStandardList(boardId);
      return tempStandardList.value;
    } else {
      return tempStandardList.value;
    }
  }

  static Future<List<SubjectListModel>?> subjectList(
      String boardId, String standardId) async {
    if (tempSubjectList.value == null ||
        tempSubjectList.value?.isEmpty == true ||
        tempSubjectList.value?.every(
                (e) => e.standardId == standardId && e.boardId == boardId) ==
            false) {
      tempSubjectList.value =
          await FirebaseGetFun().getSubjectList(boardId, standardId);
      return tempSubjectList.value;
    } else {
      return tempSubjectList.value;
    }
  }
}
