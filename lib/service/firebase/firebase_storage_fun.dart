// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

// class FirebaseStorageFun extends ApiConstant {
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//   Future<String?> uploadImage(
//       {required Uint8List file,
//       required String fileName,
//       required String name}) async {
//     try {
//       return _firebaseStorage
//           .ref("$images/$fileName/")
//           .child("${DateTime.timestamp()}_$name")
//           .putData(file, SettableMetadata(contentType: _getContentType(name)))
//           .then(
//         (p0) {
//           return p0.ref.getDownloadURL();
//         },
//       );
//     } on FirebaseException catch (e) {
//       NKToast.error(title: e.message.toString());
//       return null;
//     } on Exception catch (e) {
//       nkDevLog("IMAGE UPLOAD ERROR : ${e.toString()}");
//       return null;
//     }
//   }


//   String? _getContentType(String fileName) {
//    switch(fileName.split('.').last){
//      case "jpg" || "jpeg" || "png" || "JPG" || "JPEG" || "PNG" || "WEBp" || "webp":
//        return "image/${fileName.split('.').last}";
//      case "mp4" || "MP4" || "mov" || "MOV" || "mkv" || "MKV" || "webm" || "WEBM" || "avi" || "AVI":
//        return "video/${fileName.split('.').last}";
//        case "mp3" || "MP3":
//        return "audio/${fileName.split('.').last}";
//      default:
//        return null;
//    }
//   }
// }
