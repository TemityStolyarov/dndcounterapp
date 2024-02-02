import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndcounterapp/core/models/user.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection('users').add(user.toJson()).whenComplete(() {
      print('User successfully created!');
    });
  }
}
