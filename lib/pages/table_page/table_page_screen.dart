import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:dndcounterapp/core/models/table_data_model.dart';
import 'package:flutter/material.dart';

class TablePageScreen extends StatelessWidget {
  const TablePageScreen({
    super.key,
    required this.theme,
    required this.tablesData,
  });

  final TTxTheme theme;
  final List<TableDataModel> tablesData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (TableDataModel table in tablesData)
            Text(
              table.name,
              style: TextStyle(color: theme.fontColorPrimary),
            ),
        ],
      ),
    );
  }
}
