import 'package:dndcounterapp/components/chat_bubble/triangle.dart';
import 'package:flutter/material.dart';

class OutChatBubble extends StatelessWidget {
  const OutChatBubble({
    super.key,
    required this.backgroundColor,
    required this.child,
  });

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: child,
          ),
        ),
        CustomPaint(
          painter: Triangle(
            backgroundColor,
          ),
        ),
      ],
    );
  }
}
