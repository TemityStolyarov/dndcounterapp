import 'package:dndcounterapp/components/table_card/table_card.dart';
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
    final int length = tablesData.length + 1;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        int crossAxisCount = 1;

        if (constraints.maxWidth > 800) {
          crossAxisCount = 2;
        }
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 3;
        }

        return Padding(
          padding: const EdgeInsets.only(
            top: 0,
            bottom: 16,
            left: 16,
            right: 0,
          ),
          child: GridView.builder(
            itemCount: length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 0,
              mainAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth / crossAxisCount / 300,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == tablesData.length) {
                return TableCardAdd(theme: theme);
              }
              return TableCard(
                tableName: tablesData[index].name,
                tableDesc: tablesData[index].description,
                tableImg: tablesData[index].image,
                theme: theme,
                constraintsWidth: constraints.maxWidth,
                crossAxisCount: crossAxisCount,
              );
            },
          ),
        );
      },
    );
  }
}
