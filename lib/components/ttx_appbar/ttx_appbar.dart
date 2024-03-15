import 'package:dndcounterapp/components/ttx_switch/ttx_switch.dart';
import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';

class TTxAppBar extends StatelessWidget {
  const TTxAppBar({
    super.key,
    required this.theme,
    required this.isDefault,
    required this.onTap,
  });

  final TTxTheme theme;
  final bool isDefault;
  final VoidCallback onTap;

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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.backgroundColorTretriary,
                ),
                child: Icon(
                  Icons.settings,
                  size: 28,
                  color: theme.fontColorLabel,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          TTxSwitch(
            isDefault: isDefault,
            theme: theme,
            onTap: onTap,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
