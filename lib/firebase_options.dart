import 'package:firebase_core/firebase_core.dart';
 
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyANw4_AD3mlIfX_0vVosrrfzgo3Cj6cfUM',
      authDomain: 'catalogo-de-jogos.firebaseapp.com',
      projectId: 'catalogo-de-jogos',
      storageBucket: 'catalogo-de-jogos.firebasestorage.app',
      messagingSenderId: '713843931787',
      appId: '1:713843931787:web:be5132ee2493295335728e',
    );
  }
}