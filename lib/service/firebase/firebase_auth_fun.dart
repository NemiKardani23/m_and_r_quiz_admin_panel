import 'package:cloud_firestore/cloud_firestore.dart';

import '../../export/___app_file_exporter.dart';

class FirebaseAuthFun extends ApiConstant {
  final FirebaseFirestore _firebaseCloudStorage = FirebaseFirestore.instance;

  Future<UserDetails?> loginUser() async {
    try {
      return _firebaseCloudStorage
          .collection(baseName)
          .doc(userDetails)
          .get()
          .then((value) {
        nkDevLog("USER DATA : ${value.data()}");
        return UserDetails.fromDoc(value);
      });
    } on FirebaseException catch (e) {
      NKToast.error(title: e.message.toString());
      nkDevLog("Error: ${e.message.toString()}");
      return null;
    }
  }
}
