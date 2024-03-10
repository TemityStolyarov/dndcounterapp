import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:dndcounterapp/core/data/user_repository.dart';
import 'package:dndcounterapp/core/models/table_data_model.dart';
import 'package:dndcounterapp/pages/table_page/table_page_screen.dart';
import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();

    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: FutureBuilder(
        future: userRepository.getTableData(userId),
        builder: (context, AsyncSnapshot<List<TableDataModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final List<TableDataModel> tablesData = snapshot.data!;

          return Text(tablesData.toString());
        },
      ),
    );
  }
}
