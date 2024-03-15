import 'package:dndcounterapp/components/chat_bubble/triangle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InChatBubble extends StatelessWidget {
  const InChatBubble({
    Key? key,
    required this.child,
    required this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: Triangle(backgroundColor),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 14,
              left: 14,
              right: 14,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
