import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD9W2HVq0lb7zJ6-xl66NXzGPnb22kBqdU",
            authDomain: "tallypro-b581d.firebaseapp.com",
            projectId: "tallypro-b581d",
            storageBucket: "tallypro-b581d.firebasestorage.app",
            messagingSenderId: "1093685558034",
            appId: "1:1093685558034:web:a3a261e8a246f03a1951cb"));
  } else {
    await Firebase.initializeApp();
  }
}
