import 'package:dndcounterapp/components/dice_row/dice.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class DiceStory extends StatelessWidget {
  const DiceStory({super.key, required this.knobs});

  final KnobsBuilder knobs;

  @override
  Widget build(BuildContext context) {
    return Dice(
      d: knobs.sliderInt(
        label: 'D?',
        initial: 6,
        max: 20,
        min: 2,
      ),
      colorScheme: knobs.boolean(
        label: 'Color Scheme',
      ),
    );
  }
}
