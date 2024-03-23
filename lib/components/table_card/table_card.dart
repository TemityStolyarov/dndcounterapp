import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  const TableCard({
    super.key,
    required this.tableName,
    required this.tableDesc,
    required this.tableImg,
    required this.theme,
    required this.constraintsWidth,
    required this.crossAxisCount,
  });

  final String tableName;
  final String tableDesc;
  final String tableImg;
  final TTxTheme theme;
  final double constraintsWidth;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: theme.fontColorPrimary,
      fontWeight: FontWeight.w400,
    );

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColorTretriary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AspectRatio(
                  aspectRatio: constraintsWidth / crossAxisCount / 150,
                  child: Image.network(
                    tableImg,
                    fit: BoxFit.cover,
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
              const SizedBox(height: 12),
              Text(
                tableName,
                style: style.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
      ),
    );

    // Container(
    //   width: 400,
    //   decoration: BoxDecoration(
    //     color: theme.backgroundColorTretriary,
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(6),
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(
    //           width: 80,
    //           height: 80,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(6),
    //             child: Image.network(
    //               tableImg,
    //               fit: BoxFit.cover,
    //               isAntiAlias: true,
    //               errorBuilder: (context, error, stackTrace) {
    //                 return DecoratedBox(
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(6),
    //                     color: theme.backgroundColorPrimary,
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //         const SizedBox(width: 10),
    //         Expanded(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 children: [
    //                   Expanded(
    //                     child: Text(
    //                       tableName,
    //                       style: style.copyWith(
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                   ),
    //                   Icon(
    //                     Icons.check_rounded,
    //                     color: theme.fontColorLabel,
    //                     size: 20,
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(height: 4),
    //               Text(
    //                 tableDesc,
    //                 style: style.copyWith(
    //                   fontSize: 12,
    //                   height: 16 / 12,
    //                 ),
    //                 maxLines: 3,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(width: 4),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class TableCardAdd extends StatelessWidget {
  const TableCardAdd({
    super.key,
    required this.theme,
  });

  final TTxTheme theme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColorTretriary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.add_rounded,
          size: 32,
          color: theme.fontColorLabel,
        ),
      ),
    );
  }
}
