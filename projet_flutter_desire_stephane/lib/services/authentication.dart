import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User user){
    return user != null ? AppUser(user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future updatePassword(String currentPassword,String newPassword) async{
    final user = await FirebaseAuth.instance.currentUser;
    final credential = EmailAuthProvider.credential(email: user.email, password: currentPassword);

    user.reauthenticateWithCredential(credential).then((value){
      user.updatePassword(newPassword).then((value) {
        print('mot de passe bien changé');
      }).catchError((error){
        print('erreur de modification de mot de passe');
      });
    }).catchError((error){
      print(error);
    });
  }

  Future signInWithNameAndPswd(String name, String pswd) async {
    try{
        UserCredential result = await _auth.signInWithEmailAndPassword(email: name, password: pswd);
        User user = result.user;

        if(DatabaseService(user.uid,'').user==null){
          await DatabaseService(user.uid,'').saveUser(name, pswd, DateTime(1970, 1, 1), '', '', '');
        }

        return _userFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithNameAndPswd(String email, String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await DatabaseService(user.uid,'').saveUser(email, password, DateTime(1970, 1, 1), '', '', '');

      return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}