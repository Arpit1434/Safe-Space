import 'package:firebase_auth/firebase_auth.dart';
import 'package:safespace/models/safespace_user.dart';
import 'package:safespace/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SafeSpaceUser? _userFromFirebase(User? user) {
    return user != null ? SafeSpaceUser(uid: user.uid) : null;
  }

  Stream<SafeSpaceUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

      await DatabaseService(uid: user.uid).updateUserData(name, email);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}
