import 'package:dndcounterapp/components/dice.dart';
import 'package:flutter/material.dart';

class DiceRow extends StatelessWidget {
  final bool colorScheme;
  final Widget child;
  const DiceRow({
    super.key,
    required this.colorScheme,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'd20',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Dice(d: 20, colorScheme: colorScheme),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    'd12',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Dice(d: 12, colorScheme: colorScheme),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    'd10',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Dice(d: 10, colorScheme: colorScheme),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    'd8',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Dice(d: 8, colorScheme: colorScheme),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    'd6',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Dice(d: 6, colorScheme: colorScheme),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    'd4',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Dice(d: 4, colorScheme: colorScheme),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: child,
              )
            ],
          ),
        ],
      ),
    );
  }
}
