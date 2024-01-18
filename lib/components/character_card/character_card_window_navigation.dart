import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class ChatacterCardWindowNavigation extends StatelessWidget {
  const ChatacterCardWindowNavigation({
    super.key,
    required this.onEdit,
    required this.onChangeWrap,
    required this.onClose,
    required this.isWrapped,
  });

  final VoidCallback onEdit;
  final VoidCallback onChangeWrap;
  final VoidCallback onClose;
  final bool isWrapped;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onClose,
          child: const Icon(
            Icons.delete_outline_outlined,
            size: 18,
            color: ColorPalette.attKD,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onEdit,
          child: const Icon(
            Icons.edit,
            size: 18,
            color: ColorPalette.attKD,
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: onChangeWrap,
          child: Center(
            child: Icon(
              isWrapped
                  ? Icons.fullscreen_rounded
                  : Icons.fullscreen_exit_rounded,
              size: 22,
              color: ColorPalette.attKD,
            ),
          ),
        ),
      ],
    );
  }
}
