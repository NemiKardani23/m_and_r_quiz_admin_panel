import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';

class FirebaseGetFun extends ApiConstant {
  FirebaseFirestore storage = FirebaseFirestore.instance;

  /// BOARD
  Future<List<BoardListModel>?> getBordList() async {
    nkDevLog("--------------- GET BOARD LIST CALLED");
    try {
      return await storage.collection(board).get().then(
        (value) {
          return (value.docs as List<QueryDocumentSnapshot>)
              .map((e) =>
                  BoardListModel.fromJson(e.data() as Map<String, dynamic>))
              .toList();
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  Future<BoardListModel?> getBoard(String boardId) async {
    nkDevLog("--------------- GET BOARD LIST CALLED");
    try {
      return await storage.collection(board).doc(boardId).get().then(
        (value) {
          return BoardListModel.fromJson(value.data() as Map<String, dynamic>);
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  /// STANDARD
  Future<List<StandardListModel>?> getStandardList(String boardId) async {
    nkDevLog("--------------- GET STANDARD LIST CALLED");
    try {
      return await storage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .get()
          .then(
        (value) {
          return (value.docs as List<QueryDocumentSnapshot>)
              .map((e) =>
                  StandardListModel.fromJson(e.data() as Map<String, dynamic>))
              .toList();
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  Future<StandardListModel?> getStandard(
      String boardId, String standardId) async {
    nkDevLog("--------------- GET STANDARD CALLED");
    try {
      return await storage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .doc(standardId)
          .get()
          .then(
        (value) {
          return StandardListModel.fromJson(
              value.data() as Map<String, dynamic>);
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  /// SUBJECT
  Future<List<SubjectListModel>?> getSubjectList(
      String boardId, String standardId) async {
    nkDevLog("--------------- GET SUBJECT LIST CALLED");
    try {
      return await storage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .doc(standardId)
          .collection(subject)
          .get()
          .then(
        (value) {
          return (value.docs as List<QueryDocumentSnapshot>)
              .map((e) =>
                  SubjectListModel.fromJson(e.data() as Map<String, dynamic>))
              .toList();
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  Future<SubjectListModel?> getSubject(
      String boardId, String standardId, String subjectId) async {
    nkDevLog("--------------- GET SUBJECT CALLED");
    try {
      return await storage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .doc(standardId)
          .collection(subject)
          .doc(subjectId)
          .get()
          .then(
        (value) {
          return SubjectListModel.fromJson(
              value.data() as Map<String, dynamic>);
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  /// CHAPTER
  Future<List<ChapterListModel>?> getChapterList(
      String boardId, String standardId, String subjectId) async {
    nkDevLog("--------------- GET SUBJECT LIST CALLED");
    try {
      return await storage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .doc(standardId)
          .collection(subject)
          .doc(subjectId)
          .collection(chapter)
          .get()
          .then(
        (value) {
          return (value.docs as List<QueryDocumentSnapshot>)
              .map((e) =>
                  ChapterListModel.fromJson(e.data() as Map<String, dynamic>))
              .toList();
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  Future<ChapterListModel?> getChapter(String boardId, String standardId,
      String subjectId, String chapterId) async {
    nkDevLog("--------------- GET SUBJECT CALLED");
    try {
      return await storage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .doc(standardId)
          .collection(subject)
          .doc(subjectId)
          .collection(chapter)
          .doc(chapterId)
          .get()
          .then(
        (value) {
          return ChapterListModel.fromJson(
              value.data() as Map<String, dynamic>);
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }
}
