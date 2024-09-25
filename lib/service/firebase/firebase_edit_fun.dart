
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
// import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_delete_fun.dart';
// import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
// import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_storage_fun.dart';
// import 'package:m_and_r_quiz_admin_panel/view/app_management/model/my_learning_category_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/app_management/model/slider_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/student/model/student_list_model.dart';

// class FirebaseEditFun extends ApiConstant {
//   final FirebaseFirestore _firebaseCloudStorage = FirebaseFirestore.instance;

//   Future<BoardListModel?> editBoardDetails(
//       {required String boardId,
//       required BoardListModel bordModel,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = {
//         "boardName": bordModel.boardName,
//       };
//       if (image != null && filename != null) {
//         if (bordModel.image != null) {
//           await FirebaseDeleteFun().deleteImage(bordModel.image!);
//         }
//         map.addAll({
//           "image": await FirebaseStorageFun()
//               .uploadImage(file: image, fileName: board, name: filename)
//         });
//       }
//       await _firebaseCloudStorage
//           .collection(board)
//           .doc(boardId)
//           .set(map, SetOptions(merge: true));
//       return FirebaseGetFun().getBoard(boardId);
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   Future<StandardListModel?> editStandardDetails(
//       {String? newBoardId,
//       required String standardId,
//       required StandardListModel standardModel,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = standardModel.toJson();
//       if (image != null && filename != null) {
//         if (standardModel.image != null) {
//           await FirebaseDeleteFun().deleteImage(standardModel.image!);
//         }
//         map.addAll({
//           "image": await FirebaseStorageFun()
//               .uploadImage(file: image, fileName: standard, name: filename)
//         });
//       }
//       if (newBoardId != null) {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(standardModel.boardId)
//             .collection(standard)
//             .doc(standardId)
//             .delete();
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(newBoardId)
//             .collection(standard)
//             .doc(standardId)
//             .set(map, SetOptions(merge: true));
//       } else {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(standardModel.boardId)
//             .collection(standard)
//             .doc(standardId)
//             .set(map, SetOptions(merge: true));
//       }
//       return FirebaseGetFun()
//           .getStandard(newBoardId ?? standardModel.boardId!, standardId);
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   Future<SubjectListModel?> editSubjectDetails(
//       {String? newBoardId,
//       String? newStandardId,
//       required String subjectId,
//       required SubjectListModel subjectModel,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = subjectModel.toJson();
//       if (image != null && filename != null) {
//         if (subjectModel.image != null) {
//           await FirebaseDeleteFun().deleteImage(subjectModel.image!);
//         }
//         map.addAll({
//           "image": await FirebaseStorageFun()
//               .uploadImage(file: image, fileName: standard, name: filename)
//         });
//       }
//       if (newBoardId != null) {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(subjectModel.boardId)
//             .collection(standard)
//             .doc(subjectModel.standardId)
//             .collection(subject)
//             .doc(subjectId)
//             .delete();
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(subjectModel.boardId)
//             .collection(standard)
//             .doc(subjectModel.standardId)
//             .collection(subject)
//             .doc(subjectId)
//             .set(map, SetOptions(merge: true));
//         map.addAll({"boardId": newBoardId});
//       }
//       if (newStandardId != null) {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(subjectModel.boardId)
//             .collection(standard)
//             .doc(newStandardId)
//             .collection(subject)
//             .doc(subjectId)
//             .delete();
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(subjectModel.boardId)
//             .collection(standard)
//             .doc(newStandardId)
//             .collection(subject)
//             .doc(subjectId)
//             .set(map, SetOptions(merge: true));
//       } else {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(subjectModel.boardId)
//             .collection(standard)
//             .doc(subjectModel.standardId)
//             .collection(subject)
//             .doc(subjectId)
//             .set(map, SetOptions(merge: true));
//       }
//       return FirebaseGetFun().getSubject(newBoardId ?? subjectModel.boardId!,
//           newStandardId ?? subjectModel.standardId!, subjectId);
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   Future<ChapterListModel?> editChapterDetails(
//       {String? newBoardId,
//       String? newStandardId,
//       String? newSubjectId,
//       required String chapterId,
//       required ChapterListModel chapterModel,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = chapterModel.toJson();
//       if (image != null && filename != null) {
//         if (chapterModel.image != null) {
//           await FirebaseDeleteFun().deleteImage(chapterModel.image!);
//         }
//         map.addAll({
//           "image": await FirebaseStorageFun()
//               .uploadImage(file: image, fileName: standard, name: filename)
//         });
//       }
//       if (newBoardId != null) {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(chapterModel.boardId)
//             .collection(standard)
//             .doc(chapterModel.standardId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .collection(subject)
//             .doc(chapterModel.subjectId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .delete();
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(newBoardId)
//             .collection(standard)
//             .doc(chapterModel.standardId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .collection(subject)
//             .doc(chapterModel.subjectId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .set(map, SetOptions(merge: true));
//         map.addAll({"boardId": newBoardId});
//       }
//       if (newStandardId != null) {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(chapterModel.boardId)
//             .collection(standard)
//             .doc(chapterModel.standardId)
//             .collection(subject)
//             .doc(chapterModel.subjectId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .delete();
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(chapterModel.boardId)
//             .collection(standard)
//             .doc(newStandardId)
//             .collection(subject)
//             .doc(chapterModel.subjectId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .set(map, SetOptions(merge: true));
//       }
//       if (newSubjectId != null) {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(chapterModel.boardId)
//             .collection(standard)
//             .doc(chapterModel.standardId)
//             .collection(subject)
//             .doc(chapterModel.subjectId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .delete();
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(chapterModel.boardId)
//             .collection(standard)
//             .doc(newStandardId)
//             .collection(subject)
//             .doc(newSubjectId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .set(map, SetOptions(merge: true));
//       } else {
//         await _firebaseCloudStorage
//             .collection(board)
//             .doc(chapterModel.boardId)
//             .collection(standard)
//             .doc(chapterModel.standardId)
//             .collection(subject)
//             .doc(newSubjectId)
//             .collection(chapter)
//             .doc(chapterModel.chapterId)
//             .set(map, SetOptions(merge: true));
//       }
//       return FirebaseGetFun().getChapter(
//           newBoardId ?? chapterModel.boardId!,
//           newStandardId ?? chapterModel.standardId!,
//           newSubjectId ?? chapterModel.subjectId!,
//           chapterId);
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   Future<StudentListModel?> editStudent(
//       {required String studentId,
//       required StudentListModel studentModel,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = studentModel.toJson();
//       if (image != null && filename != null) {
//         if (studentModel.image != null) {
//           await FirebaseDeleteFun().deleteImage(studentModel.image!);
//         }
//         map.addAll({
//           "image": await FirebaseStorageFun()
//               .uploadImage(file: image, fileName: student, name: filename)
//         });
//       }

//       await _firebaseCloudStorage
//           .collection(student)
//           .doc(studentId)
//           .update(map);

//       return FirebaseGetFun().getStudent(studentId);
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//     /// SLIDER
//   Future<SliderListModel?> editAppDashboardSlider(
//       {required SliderListModel sliderData,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = sliderData.toJson();
//       if (image != null && filename != null) {
//         if (sliderData.image != null) {
//           await FirebaseDeleteFun().deleteImage(sliderData.image!);
//         }
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: "$appManagement/$appDashboard", name: filename))!;
//       }
//       return await _firebaseCloudStorage
//            .collection(appManagement)
//           .doc(appDashboard)
//           .collection(slider).doc(sliderData.sliderId)
//           .update(
//             map,
//           )
//           .then(
//         (value) {
        

//           return FirebaseGetFun().getAppDashboardSingleSlider(sliderData.sliderId!);
//         },
//       );
//     } on FirebaseException catch (e) {
//       nkDevLog("ADD STUDENT ERROR : ${e.message.toString()}");
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }
//     /// MY LEARNING CATEGORY
//   Future<MyLearningCategoryListModel?> editAppMyLearningCategory(
//       {required MyLearningCategoryListModel myLearningCategory,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = myLearningCategory.toJson();
//       if (image != null && filename != null) {
//         if (myLearningCategory.image != null) {
//           await FirebaseDeleteFun().deleteImage(myLearningCategory.image!);
//         }
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: "$appManagement/$appDashboard", name: filename))!;
//       }
//       return await _firebaseCloudStorage
//            .collection(appManagement)
//           .doc(appMyLearning)
//           .collection(category).doc(myLearningCategory.categoryId)
//           .update(
//             map,
//           )
//           .then(
//         (value) {
        

//           return FirebaseGetFun().getAppMyLearningSingleCategory(myLearningCategory.categoryId!);
//         },
//       );
//     } on FirebaseException catch (e) {
//       nkDevLog("ADD APP MY LEARNING CATEGORY ERROR : ${e.message.toString()}");
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

// }
