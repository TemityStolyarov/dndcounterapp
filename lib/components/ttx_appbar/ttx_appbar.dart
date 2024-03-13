import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';

class TTxAppBar extends StatelessWidget {
  const TTxAppBar({
    super.key,
    required this.theme,
  });

  final TTxTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 32,
            width: 32,
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              radius: 32,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(
                Icons.account_circle_rounded,
                size: 32,
                color: theme.fontColorLabel,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
