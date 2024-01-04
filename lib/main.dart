import 'package:dndcounterapp/components/card/character_modal/charbook_add_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/charbook_edit_modal.dart';
import 'package:dndcounterapp/components/charbook_widget.dart';
import 'package:dndcounterapp/components/dice_row/dice_row.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CharBookAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(WeaponAdapter());
  Hive.registerAdapter(SpellAdapter());
  await Hive.openBox<CharBook>('charbook');
  Box<CharBook> box = Hive.box<CharBook>('charbook');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.brown)),
    home: MainApp(box: box),
  ));
}

class MainApp extends StatefulWidget {
  final Box<CharBook> box;
  const MainApp({super.key, required this.box});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool colorScheme = true;
  List<CharBook> charbooks = [];
  String json = '';

  @override
  void initState() {
    _updateCards();
    super.initState();
  }

  @override
  void dispose() async {
    await widget.box.close();
    super.dispose();
  }

  void _updateCards() {
    setState(() {
      charbooks = widget.box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      json =
          jsonEncode(charbooks.map((charbook) => charbook.toJson()).toList());
    });

    return Scaffold(
      backgroundColor: colorScheme
          ? ColorPalette.alternativeBackgroundColor
          : ColorPalette.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 100),
        child: DiceRow(
          json: json,
          box: widget.box,
          onImport: _updateCards,
          charBooks: charbooks,
          colorScheme: colorScheme,
          childSwitch: Switch.adaptive(
            activeColor: ColorPalette.accentColor,
            splashRadius: 0,
            value: colorScheme,
            onChanged: (value) {
              setState(() {
                colorScheme = value;
              });
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  for (int charbookIndex = 0;
                      charbookIndex < charbooks.length;
                      charbookIndex++)
                    _CharbookCard(
                      charbookIndex: charbookIndex,
                      charbooks: charbooks,
                      charbookBox: widget.box,
                      colorScheme: colorScheme,
                      onTapSection: () {
                        final sectionEditModal = CharbookEditModal(
                          box: widget.box,
                          charbookIndex: charbookIndex,
                          onUpdateScreen: _updateCards,
                        );
                        sectionEditModal.show(context);
                      },
                      onUpdateScreen: _updateCards,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40,
                      top: 40,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          final charbookAddModal = CharbookAddModal(
                            box: widget.box,
                            onAdd: _updateCards,
                          );
                          charbookAddModal.show(context);
                        },
                        tooltip: 'Добавить раздел',
                        backgroundColor: ColorPalette.cardColor,
                        child: const Icon(
                          Icons.add,
                          color: ColorPalette.alternativeshadowColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharbookCard extends StatelessWidget {
  final int charbookIndex;
  final Box charbookBox;
  final List<CharBook> charbooks;
  final bool colorScheme;
  final VoidCallback onTapSection;
  final VoidCallback onUpdateScreen;

  const _CharbookCard({
    required this.charbookIndex,
    required this.charbooks,
    required this.charbookBox,
    required this.colorScheme,
    required this.onTapSection,
    required this.onUpdateScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        InkWell(
          onTap: onTapSection,
          child: Container(
            width: 380,
            decoration: BoxDecoration(
              color: ColorPalette.backgroundSectionName,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme
                      ? ColorPalette.alternativeshadowColor
                      : ColorPalette.shadowColor,
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  charbooks[charbookIndex].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.fontBaseColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Wrap(
            children: [
              CharbookWidget(
                charbooks: charbooks,
                charbookBox: charbookBox,
                charbookIndex: charbookIndex,
                colorScheme: colorScheme,
                onUpdateScreen: onUpdateScreen,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
