import 'package:dndcounterapp/storybook/screens/register_page_screen_story.dart';
import 'package:dndcounterapp/storybook/widgets/dice_story.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const StorybookApp());
}

class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

  @override
  Widget build(BuildContext context) => Storybook(
        wrapperBuilder: (context, child) {
          if (child == null) return const SizedBox();

          return Material(
            child: Center(
              child: child,
            ),
          );
        },
        stories: [
          Story(
            name: 'Screens/Register Page',
            // description: 'Demo Counter app with about dialog.',
            // builder:(context) =>
            // title: context.knobs.text(label: 'Title', initial: 'Counter'),
            //   enabled: context.knobs.boolean(label: 'Enabled', initial: true),
            builder: (context) => const RegisterPageStory(),
          ),
          Story(
            name: 'Widgets/Dice',
            description: 'One unit of rolling cubes',
            builder: (context) => DiceStory(knobs: context.knobs),
          ),
        ],
      );
}
