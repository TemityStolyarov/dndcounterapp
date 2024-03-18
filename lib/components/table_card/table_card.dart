import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  const TableCard({
    super.key,
    required this.tableName,
    required this.tableDesc,
    required this.tableImg,
    required this.theme,
  });

  final String tableName;
  final String tableDesc;
  final String tableImg;
  final TTxTheme theme;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: theme.fontColorPrimary,
      fontWeight: FontWeight.w400,
    );

    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: theme.backgroundColorTretriary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  tableImg,
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                  errorBuilder: (context, error, stackTrace) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: theme.backgroundColorPrimary,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          tableName,
                          style: style.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.check_rounded,
                        color: theme.fontColorLabel,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tableDesc,
                    style: style.copyWith(
                      fontSize: 12,
                      height: 16 / 12,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
