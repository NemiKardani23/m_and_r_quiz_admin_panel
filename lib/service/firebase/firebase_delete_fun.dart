import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class FirebaseDeleteFun extends ApiConstant {
  final FirebaseFirestore _firebaseCloudStorage = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> deleteImage(String imageUrl) async {
    await _firebaseStorage.refFromURL(imageUrl).delete();
  }

  /// BOARD
  Future<void> deleteBoard(String boardId, {String? imageUrl}) async {
    if (imageUrl != null) {
      await deleteImage(imageUrl);
    }
    await _firebaseCloudStorage.collection(board).doc(boardId).delete();
  }

  /// STANDARD
  Future<void> deleteStandard(String boardId, String standardId,
      {String? imageUrl}) async {
    if (imageUrl != null) {
      await deleteImage(imageUrl);
    }
    await _firebaseCloudStorage
        .collection(board)
        .doc(boardId)
        .collection(standard)
        .doc(standardId)
        .delete();
    return;
  }

  /// SUBJECT
  Future<void> deleteSubject(
      String boardId, String standardId, String subjectId,
      {String? imageUrl}) async {
    if (imageUrl != null) {
      await deleteImage(imageUrl);
    }
    await _firebaseCloudStorage
        .collection(board)
        .doc(boardId)
        .collection(standard)
        .doc(standardId)
        .collection(subject)
        .doc(subjectId)
        .delete();
    return;
  }
  /// CHAPTER
  Future<void> deleteChapter(
      String boardId, String standardId, String subjectId, String chapterId,
      {String? imageUrl}) async {
    if (imageUrl != null) {
      await deleteImage(imageUrl);
    }
    await _firebaseCloudStorage
        .collection(board)
        .doc(boardId)
        .collection(standard)
        .doc(standardId)
        .collection(subject)
        .doc(subjectId).collection(chapter).doc(chapterId)
        .delete();
    return;
  }
}
