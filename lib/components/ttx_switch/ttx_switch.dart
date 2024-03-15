import 'package:dndcounterapp/components/ttx_switch/ttx_switch_button.dart';
import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';

class TTxSwitch extends StatefulWidget {
  const TTxSwitch({
    super.key,
    this.onTap,
    required this.isDefault,
    required this.theme,
  });

  final VoidCallback? onTap;
  final bool isDefault;
  final TTxTheme theme;

  @override
  State<TTxSwitch> createState() => _TTxSwitchState();
}

class _TTxSwitchState extends State<TTxSwitch> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(6);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.theme.backgroundColorTretriary,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TTxSwitchButton(
              isDefault: widget.isDefault,
              onTap: !widget.isDefault ? widget.onTap : null,
              borderRadius: borderRadius,
              label: 'Столы',
              theme: widget.theme,
            ),
            const SizedBox(width: 3),
            TTxSwitchButton(
              isDefault: !widget.isDefault,
              onTap: widget.isDefault ? widget.onTap : null,
              borderRadius: borderRadius,
              label: 'Персонажи',
              theme: widget.theme,
            ),
          ],
        ),
      ),
    );
  }
}
