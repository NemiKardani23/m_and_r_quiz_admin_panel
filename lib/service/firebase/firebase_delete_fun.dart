// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

// class FirebaseDeleteFun extends ApiConstant {
//   final FirebaseFirestore _firebaseCloudStorage = FirebaseFirestore.instance;
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//   Future<void> deleteImage(String imageUrl) async {
//     await _firebaseStorage.refFromURL(imageUrl).delete();
//   }

//   /// BOARD
//   Future<void> deleteBoard(String boardId, {String? imageUrl}) async {
//     if (imageUrl != null) {
//       await deleteImage(imageUrl);
//     }
//     await _firebaseCloudStorage.collection(board).doc(boardId).delete();
//   }

//   /// STANDARD
//   Future<void> deleteStandard(String boardId, String standardId,
//       {String? imageUrl}) async {
//     if (imageUrl != null) {
//       await deleteImage(imageUrl);
//     }
//     await _firebaseCloudStorage
//         .collection(board)
//         .doc(boardId)
//         .collection(standard)
//         .doc(standardId)
//         .delete();
//     return;
//   }

<<<<<<< Updated upstream
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
}
=======
//   /// SUBJECT
//   Future<void> deleteSubject(
//       String boardId, String standardId, String subjectId,
//       {String? imageUrl}) async {
//     if (imageUrl != null) {
//       await deleteImage(imageUrl);
//     }
//     await _firebaseCloudStorage
//         .collection(board)
//         .doc(boardId)
//         .collection(standard)
//         .doc(standardId)
//         .collection(subject)
//         .doc(subjectId)
//         .delete();
//     return;
//   }
//   /// CHAPTER
//   Future<void> deleteChapter(
//       String boardId, String standardId, String subjectId, String chapterId,
//       {String? imageUrl}) async {
//     if (imageUrl != null) {
//       await deleteImage(imageUrl);
//     }
//     await _firebaseCloudStorage
//         .collection(board)
//         .doc(boardId)
//         .collection(standard)
//         .doc(standardId)
//         .collection(subject)
//         .doc(subjectId).collection(chapter).doc(chapterId)
//         .delete();
//     return;
//   }
//   /// STUDENT
//   Future<void> deleteStudent(
//       String studentId,
//       {String? imageUrl}) async {
//     if (imageUrl != null) {
//       await deleteImage(imageUrl);
//     }
//     await _firebaseCloudStorage
//         .collection(student)
//         .doc(studentId)
//         .delete();
//     return;
//   }

//     /// SLIDER
//   Future<void> deleteAppDashboardSlider(
//       String sliderId,
//       {String? imageUrl}) async {
//     if (imageUrl != null) {
//       await deleteImage(imageUrl);
//     }
//     await _firebaseCloudStorage
//          .collection(appManagement)
//           .doc(appDashboard).collection(slider)
//         .doc(sliderId)
//         .delete();
//     return;
//   }

//     /// MY LEARNING CATEGORY
//   Future<void> deleteAppMyLearningCategory(
//       String sliderId,
//       {String? imageUrl}) async {
//     if (imageUrl != null) {
//       await deleteImage(imageUrl);
//     }
//     await _firebaseCloudStorage
//          .collection(appManagement)
//           .doc(appMyLearning).collection(category)
//         .doc(sliderId)
//         .delete();
//     return;
//   }
// }
>>>>>>> Stashed changes
