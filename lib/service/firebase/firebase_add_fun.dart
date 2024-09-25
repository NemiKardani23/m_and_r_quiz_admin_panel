<<<<<<< Updated upstream
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_storage_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';
=======
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
// import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
// import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_storage_fun.dart';
// import 'package:m_and_r_quiz_admin_panel/view/app_management/model/my_learning_category_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/app_management/model/slider_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';
// import 'package:m_and_r_quiz_admin_panel/view/student/model/student_list_model.dart';
>>>>>>> Stashed changes

// class FirebaseAddFun with ApiConstant {
//   final FirebaseFirestore _firebaseCloudStorage = FirebaseFirestore.instance;

<<<<<<< Updated upstream
  /// BOARD
  Future<BoardListModel?> addBoard(
      {required String boardName, Uint8List? image, String? filename}) async {
    try {
      var map = {
        "boardName": boardName,
        "boardId": "",
        "createdAt": DateTime.timestamp()
      };
      if (image != null && filename != null) {
        map["image"] = (await FirebaseStorageFun()
            .uploadImage(file: image, fileName: standard, name: filename))!;
      }
      return await _firebaseCloudStorage
          .collection(board)
          .add(
            map,
          )
          .then(
        (value) {
          value.update({"boardId": value.id});
          return FirebaseGetFun().getBoard(value.id);
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  /// STANDARD
  Future<StandardListModel?> addStandard(
      {required String standardName,
      required String boardId,
      Uint8List? image,
      String? filename}) async {
    try {
      var map = {
        "standardName": standardName,
        "standardId": "",
        "boardId": boardId,
        "createdAt": DateTime.timestamp()
      };
      if (image != null && filename != null) {
        map["image"] = (await FirebaseStorageFun()
            .uploadImage(file: image, fileName: standard, name: filename))!;
      }
      return await _firebaseCloudStorage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .add(
            map,
          )
          .then(
        (value) {
          value.update({"standardId": value.id});
          return FirebaseGetFun().getStandard(boardId, value.id);
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  /// SUBJECT
  Future<SubjectListModel?> addSubject(
      {required String subjectName,
      required String boardId,
      required String standardId,
      Uint8List? image,
      String? filename}) async {
    try {
      var map = {
        "subjectName": subjectName,
        "standardId": standardId,
        "subjectId": "",
        "boardId": boardId,
        "createdAt": DateTime.timestamp()
      };
      if (image != null && filename != null) {
        map["image"] = (await FirebaseStorageFun()
            .uploadImage(file: image, fileName: standard, name: filename))!;
      }
      return await _firebaseCloudStorage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .doc(standardId)
          .collection(subject)
          .add(
            map,
          )
          .then(
        (value) {
          value.update({"subjectId": value.id});
          return FirebaseGetFun().getSubject(boardId, standardId, value.id);
        },
      );
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      return null;
    }
  }

  /// SUBJECT
  Future<ChapterListModel?> addChapter(
      {required String chapterName,
      required String boardId,
      required String standardId,
      required String subjectId,
      Uint8List? image,
      String? filename}) async {
    try {
      var map = {
        "chapterName": chapterName,
        "standardId": standardId,
        "subjectId": subjectId,
        "chapterId": "",
        "boardId": boardId,
        "createdAt": DateTime.timestamp()
      };
      if (image != null && filename != null) {
        map["image"] = (await FirebaseStorageFun()
            .uploadImage(file: image, fileName: chapter, name: filename))!;
      }
      return await _firebaseCloudStorage
          .collection(board)
          .doc(boardId)
          .collection(standard)
          .doc(standardId)
          .collection(subject)
          .doc(subjectId)
          .collection(chapter)
          .add(
            map,
          )
          .then(
        (value) {
          value.update({"chapterId": value.id});
          return null;
          // return FirebaseGetFun()
          //     .getChapter(boardId, standardId, subjectId, value.id);
        },
      );
    } on FirebaseException catch (e) {
      nkDevLog("ADD CHAPTER ERROR : ${e.message.toString()}");
      NKToast.error(title: e.message.toString());
      return null;
    }
  }
}
=======
//   /// BOARD
//   Future<BoardListModel?> addBoard(
//       {required String boardName, Uint8List? image, String? filename}) async {
//     try {
//       var map = {
//         "boardName": boardName,
//         "boardId": "",
//         "createdAt": DateTime.timestamp().toString()
//       };
//       if (image != null && filename != null) {
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: standard, name: filename))!;
//       }
//       return await _firebaseCloudStorage
//           .collection(board)
//           .add(
//             map,
//           )
//           .then(
//         (value) {
//           value.update({"boardId": value.id});
//           return FirebaseGetFun().getBoard(value.id);
//         },
//       );
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   /// STANDARD
//   Future<StandardListModel?> addStandard(
//       {required String standardName,
//       required String boardId,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = {
//         "standardName": standardName,
//         "standardId": "",
//         "boardId": boardId,
//         "createdAt": DateTime.timestamp().toString()
//       };
//       if (image != null && filename != null) {
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: standard, name: filename))!;
//       }
//       return await _firebaseCloudStorage
//           .collection(board)
//           .doc(boardId)
//           .collection(standard)
//           .add(
//             map,
//           )
//           .then(
//         (value) {
//           value.update({"standardId": value.id});
//           return FirebaseGetFun().getStandard(boardId, value.id);
//         },
//       );
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   /// SUBJECT
//   Future<SubjectListModel?> addSubject(
//       {required String subjectName,
//       required String boardId,
//       required String standardId,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = {
//         "subjectName": subjectName,
//         "standardId": standardId,
//         "subjectId": "",
//         "boardId": boardId,
//         "createdAt": DateTime.timestamp().toString()
//       };
//       if (image != null && filename != null) {
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: standard, name: filename))!;
//       }
//       return await _firebaseCloudStorage
//           .collection(board)
//           .doc(boardId)
//           .collection(standard)
//           .doc(standardId)
//           .collection(subject)
//           .add(
//             map,
//           )
//           .then(
//         (value) {
//           value.update({"subjectId": value.id});
//           return FirebaseGetFun().getSubject(boardId, standardId, value.id);
//         },
//       );
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   /// SUBJECT
//   Future<ChapterListModel?> addChapter(
//       {required String chapterName,
//       required String boardId,
//       required String standardId,
//       required String subjectId,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = {
//         "chapterName": chapterName,
//         "standardId": standardId,
//         "subjectId": subjectId,
//         "chapterId": "",
//         "boardId": boardId,
//         "createdAt": DateTime.timestamp().toString().toString()
//       };
//       if (image != null && filename != null) {
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: chapter, name: filename))!;
//       }
//       return await _firebaseCloudStorage
//           .collection(board)
//           .doc(boardId)
//           .collection(standard)
//           .doc(standardId)
//           .collection(subject)
//           .doc(subjectId)
//           .collection(chapter)
//           .add(
//             map,
//           )
//           .then(
//         (value) {
//           value.update({"chapterId": value.id});
//           return null;
//           // return FirebaseGetFun()
//           //     .getChapter(boardId, standardId, subjectId, value.id);
//         },
//       );
//     } on FirebaseException catch (e) {
//       nkDevLog("ADD CHAPTER ERROR : ${e.message.toString()}");
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   /// STUDENT
//   Future<StudentListModel?> addStudent(
//       {required String studentName,
//       required String studentNumber,
//       required String numberCountryCode,
//       required String boardId,
//       required String standardId,
//       required String studentCity,
//       required String studentState,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = {
//         "studentName": studentName,
//         "studentNumber": studentNumber,
//         "numberCountryCode": numberCountryCode,
//         "studentCity": studentCity,
//         "studentState": studentState,
//         "boardId": boardId,
//         "standardId": standardId,
//         "fcm_tocken": "",
//         "device_name": "",
//         "device_id": "",
//         "studentId": "",
//         "createdAt": DateTime.timestamp().toString().toString()
//       };
//       if (image != null && filename != null) {
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: student, name: filename))!;
//       }
//       return await _firebaseCloudStorage
//           .collection(student)
//           .add(
//             map,
//           )
//           .then(
//         (value) {
//           value.update({"studentId": value.id});

//           return FirebaseGetFun().getStudent(value.id);
//         },
//       );
//     } on FirebaseException catch (e) {
//       nkDevLog("ADD STUDENT ERROR : ${e.message.toString()}");
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }

//   /// SLIDER
//   Future<SliderListModel?> addAppDashboardSlider(
//       {required SliderListModel sliderData,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = sliderData.toJson();

//       map.remove("sliderId");
//       map.update(
//         "createdAt",
//         (value) => DateTime.timestamp().toString(),
//       );
//       if (image != null && filename != null) {
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: "$appManagement/$appDashboard/$slider", name: filename))!;
//       }
//       return await _firebaseCloudStorage
//           .collection(appManagement)
//           .doc(appDashboard)
//           .collection(slider)
//           .add(
//             map,
//           )
//           .then(
//         (value) {
//           value.update({"sliderId": value.id});
         
//           return FirebaseGetFun().getAppDashboardSingleSlider(value.id);
//         },
//       );
//     } on FirebaseException catch (e) {
//       nkDevLog("ADD STUDENT ERROR : ${e.message.toString()}");
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }


//   /// My Learning Category
//   Future<MyLearningCategoryListModel?> addMyLearningCategory(
//       {required MyLearningCategoryListModel myLearningCategoryData,
//       Uint8List? image,
//       String? filename}) async {
//     try {
//       var map = myLearningCategoryData.toJson();

//       map.remove("categoryId");
//       map.update(
//         "createdAt",
//         (value) => DateTime.timestamp().toString(),
//       );
//       if (image != null && filename != null) {
//         map["image"] = (await FirebaseStorageFun()
//             .uploadImage(file: image, fileName: "$appManagement/$appMyLearning/$category", name: filename))!;
//       }
//       return await _firebaseCloudStorage
//           .collection(appManagement)
//           .doc(appMyLearning)
//           .collection(category)
//           .add(
//             map,
//           )
//           .then(
//         (value) {
//           value.update({"categoryId": value.id});
         
//           return FirebaseGetFun().getAppMyLearningSingleCategory(value.id);
//         },
//       );
//     } on FirebaseException catch (e) {
//       nkDevLog("ADD MY LEARNING CATEGORY ERROR : ${e.message.toString()}");
//       NKToast.error(title: e.message.toString());
//       return null;
//     }
//   }
// }
>>>>>>> Stashed changes
