import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class CharacterDescription extends StatelessWidget {
  const CharacterDescription({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return character.description == '' && character.mechanics == ''
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (character.mechanics.toString().isEmpty ||
                        character.mechanics == null)
                    ? SizedBox(
                        width: 794,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Описание: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorPalette.fontBaseColor,
                                ),
                              ),
                              TextSpan(
                                text: character.description,
                                style: const TextStyle(
                                  color: ColorPalette.fontBaseColor,
                                  height: 14 / 12,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: 794,
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Описание: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorPalette.fontBaseColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: character.description,
                                    style: const TextStyle(
                                      color: ColorPalette.fontBaseColor,
                                      height: 14 / 12,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 794,
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Механики: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorPalette.fontBaseColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: character.mechanics,
                                    style: const TextStyle(
                                      color: ColorPalette.fontBaseColor,
                                      height: 14 / 12,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
  }
}
