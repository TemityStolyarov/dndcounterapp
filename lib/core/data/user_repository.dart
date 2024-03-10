import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndcounterapp/core/models/table_data_model.dart';
import 'package:dndcounterapp/core/models/user.dart';
import 'package:dndcounterapp/core/models/user_data_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection('users').add(user.toJson()).whenComplete(() {
      print('User successfully created!');
    });
  }

  Future<UserDataModelConverted> getUserData(String userEmail) async {
    try {
      // Получение данных пользователя из Firestore
      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Пользователь не найден
        throw Exception('User not found');
      }

      // Получение данных пользователя
      final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      final userDataModel = UserDataModel.fromJson(userData);

      final String userId = querySnapshot.docs.first.id;
      return UserDataModelConverted(
        userId: userId,
        linkedTables: userDataModel.linkedTables,
        email: userDataModel.email,
        nickname: userDataModel.nickname,
      );
    } catch (error) {
      // Обработка ошибок
      throw Exception('Unknown error: $error');
    }
  }

  Future<List<TableDataModel>> getTableData(String userId) async {
    try {
      // Получение данных пользователя из Firestore
      QuerySnapshot querySnapshot =
          await _db.collection('users/$userId/tables').get();

      if (querySnapshot.docs.isEmpty) {
        // Пользователь не найден
        throw Exception('err1'); //TODO
      }

      List<Map<String, dynamic>> tableData = querySnapshot.docs
          .map((table) => table.data() as Map<String, dynamic>)
          .toList();

      List<TableDataModel> tables = [];
      for (Map<String, dynamic> table in tableData) {
        tables.add(TableDataModel.fromJson(table));
      }

      return tables;
    } catch (error) {
      // Обработка ошибок
      throw Exception('err2'); //TODO
    }
  }
}
