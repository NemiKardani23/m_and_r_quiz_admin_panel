import 'package:firebase_core/firebase_core.dart';
import 'package:m_and_r_quiz_admin_panel/firebase_options.dart';

class FirebaseInit {
  static Future<FirebaseApp> init() async {
    return await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
