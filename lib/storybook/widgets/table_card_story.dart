import 'package:dndcounterapp/components/table_card/table_card.dart';
import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class TableCardStory extends StatelessWidget {
  const TableCardStory({super.key, required this.knobs});

  final KnobsBuilder knobs;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TableCard(
        tableName: knobs.text(
          label: 'Название',
          initial: 'Greece Odissy',
        ),
        tableDesc: knobs.text(
          label: 'Описание',
          initial: 'Vabba Labba Dab Dab!',
        ),
        tableImg: knobs.text(
          label: 'Ссылка на изображение',
          initial:
              'https://i.postimg.cc/34nczVqG/photo-2024-02-26-20-39-48.jpg',
        ),
        theme: knobs.options(
          label: 'Тема',
          initial: ColorTheme.light,
          options: [
            Option(label: 'Светлая', value: ColorTheme.light),
            Option(label: 'Темная', value: ColorTheme.dark),
          ],
        ),
        constraintsWidth: 400,
        crossAxisCount: 3,
      ),
    );
  }
}
