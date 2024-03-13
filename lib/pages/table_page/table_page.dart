import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:dndcounterapp/core/data/user_repository.dart';
import 'package:dndcounterapp/core/models/table_data_model.dart';
import 'package:dndcounterapp/pages/table_page/table_page_screen.dart';
import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  const TablePage({
    super.key,
    required this.userId,
    required this.theme,
  });

  final String userId;
  final TTxTheme theme;

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();

    return FutureBuilder(
      future: userRepository.getTableData(userId),
      builder: (context, AsyncSnapshot<List<TableDataModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // TODO
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final List<TableDataModel> tablesData = snapshot.data!;

        return TablePageScreen(
          theme: theme,
          tablesData: tablesData.toString(),
        );
      },
    );
  }
}
