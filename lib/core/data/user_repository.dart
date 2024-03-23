import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndcounterapp/core/models/table_data_model.dart';
import 'package:dndcounterapp/core/models/user.dart';
import 'package:dndcounterapp/core/models/user_data_model.dart';
import 'package:logger/logger.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final logger = Logger();

  createUser(UserModel user) async {
    await _db.collection('users').add(user.toJson()).whenComplete(() {
      print('User successfully created!');
    });
  }

  Future<UserDataModelConverted> getUserData(String userEmail) async {
    try {
      // // Получение данных пользователя из Firestore
      // QuerySnapshot querySnapshot = await _db
      //     .collection('users')
      //     .where('email', isEqualTo: userEmail)
      //     .get();

      // if (querySnapshot.docs.isEmpty) {
      //   // Пользователь не найден
      //   throw Exception('User not found');
      // }

      // // Получение данных пользователя
      // final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      // final userDataModel = UserDataModel.fromJson(userData);

      // final String userId = querySnapshot.docs.first.id;
      // final userDataModelConverted = UserDataModelConverted(
      //   userId: userId,
      //   linkedTables: userDataModel.linkedTables,
      //   email: userDataModel.email,
      //   nickname: userDataModel.nickname,
      //   lightTheme: userDataModel.lightTheme,
      // );
      final userDataModelConverted = UserDataModelConverted(
        userId: 'Ks16ve0TBZAymq05uhJ2',
        linkedTables: ['test_table_id'],
        email: 'imweiixxi@gmail.com',
        nickname: 'Артем',
        lightTheme: false,
      );
      logger.t(
          '##GET UserDataModelConverted: \n${userDataModelConverted.userId},\n${userDataModelConverted.linkedTables},\n${userDataModelConverted.email},\n${userDataModelConverted.nickname},\n${userDataModelConverted.lightTheme}');
      return userDataModelConverted;
    } catch (error) {
      // Обработка ошибок
      throw Exception('Unknown error: $error');
    }
  }

  Future<List<TableDataModel>> getTableData(String userId) async {
    try {
      // // Получение данных пользователя из Firestore
      // QuerySnapshot querySnapshot =
      //     await _db.collection('users/$userId/tables').get();

      // if (querySnapshot.docs.isEmpty) {
      //   // Пользователь не найден
      //   throw Exception('err1'); //TODO
      // }

      // List<Map<String, dynamic>> tableData = querySnapshot.docs
      //     .map((table) => table.data() as Map<String, dynamic>)
      //     .toList();

      // List<TableDataModel> tables = [];
      // for (Map<String, dynamic> table in tableData) {
      //   tables.add(TableDataModel.fromJson(table));
      //   logger.i(table.toString());
      // }

      final List<TableDataModel> tables = [
        TableDataModel(
          name: 'Greece Odissy1',
          description:
              'Vabba Labba Dab Dab Vabba Labba Dab Dab VDab abba LaDab bba DabDab  Dab VabbaDab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab  Dab LDab abba Dab Dab ',
          image: 'https://i.postimg.cc/34nczVqG/photo-2024-02-26-20-39-48.jpg',
          visibleForSelect: true,
          data: '[]',
        ),
        TableDataModel(
          name:
              'Greece Odissy2 ba Labba Dab Dab Vabba Labba Dab Dab VDab abba L',
          description:
              'Vabba Labba Dab Dab Vabba Labba Dab Dab VDab abba LaDab bba DabDab  Dab VabbaDab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab  Dab LDab abba Dab Dab ',
          image: 'https://i.postimg.cc/34nczVqG/photo-2024-02-26-20-39-48.jpg',
          visibleForSelect: true,
          data: '[]',
        ),
        TableDataModel(
          name: 'Greece Odissy3',
          description:
              'Vabba Labba Dab Dab Vabba Labbaba Labba Dab Dab Vabba Labba Dab Dab VDab abba Lba Labba Dab Dab Vabba Labba Dab Dab VDab abba Lba Labba Dab Dab Vabba Labba Dab Dab VDab abba Lba Labba Dab Dab Vabba Labba Dab Dab VDab abba Lba Labba Dab Dab Vabba Labba Dab Dab VDab abba Lba Labba Dab Dab Vabba Labba Dab Dab VDab abba L Dab Dab VDab abba LaDab bba DabDab  Dab VabbaDab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab Dab  Dab LDab abba Dab Dab ',
          image: 'https://i.postimg.cc/34nczVqG/photo-2024-02-26-20-39-48.jpg',
          visibleForSelect: true,
          data: '[]',
        ),
      ];
      logger.i(tables);
      return tables;
    } catch (error) {
      // Обработка ошибок
      throw Exception('err2'); //TODO
    }
  }
}
