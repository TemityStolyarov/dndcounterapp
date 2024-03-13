import 'package:dndcounterapp/components/ttx_switch/ttx_switch.dart';
import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';

class TablePageScreen extends StatefulWidget {
  const TablePageScreen({
    super.key,
    required this.theme,
    required this.tablesData,
  });

  final TTxTheme theme;
  final String tablesData;

  @override
  State<TablePageScreen> createState() => _TablePageScreenState();
}

class _TablePageScreenState extends State<TablePageScreen> {
  bool isDefault = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TTxSwitch(
                isDefault: isDefault,
                theme: widget.theme,
                onTap: () {
                  setState(() {
                    isDefault = !isDefault;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          SelectableText(
            widget.tablesData,
            style: TextStyle(color: widget.theme.fontColorPrimary),
          ),
        ],
      ),
    );
  }
}
