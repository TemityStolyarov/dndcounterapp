import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndcounterapp/core/models/user.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection('users').add(user.toJson()).whenComplete(() {
      print('User successfully created!');
    });
  }

  Future<Map<String, dynamic>> getUserData(String userEmail) async {
    try {
      // Получение данных пользователя из Firestore
      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Пользователь не найден
        return {'error': 'User not found'};
      }

      // Получение данных пользователя
      Map<String, dynamic> userData =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      return userData;
    } catch (error) {
      // Обработка ошибок
      return {'error': error.toString()};
    }
  }
}
