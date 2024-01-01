import 'package:dndcounterapp/core/models/character.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterEditModal {
  final Box box;
  final VoidCallback onSave;
  final int index;

  CharacterEditModal({
    required this.box,
    required this.onSave,
    required this.index,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Character char = Character.empty();
        try {
          char = box.getAt(index)!;
        } catch (e) {
          print(e);
        }

        final ctrName = TextEditingController();
        ctrName.text = char.name;
        final ctrRace = TextEditingController();
        ctrRace.text = char.race;
        final ctrClass = TextEditingController();
        ctrClass.text = char.crClass;
        final ctrHP = TextEditingController();
        ctrHP.text = char.hp.toString();
        final ctrHPMod = TextEditingController();
        ctrHPMod.text = char.hpModifier.toString();
        final ctrAR = TextEditingController();
        ctrAR.text = char.kd.toString();
        final ctrSTR = TextEditingController();
        ctrSTR.text = char.strength.toString();
        final ctrAGL = TextEditingController();
        ctrAGL.text = char.agility.toString();
        final ctrINT = TextEditingController();
        ctrINT.text = char.intelligence.toString();
        final ctrATL = TextEditingController();
        ctrATL.text = char.athletics.toString();
        final ctrCAR = TextEditingController();
        ctrCAR.text = char.charisma.toString();
        final ctrWIS = TextEditingController();
        ctrWIS.text = char.wisdom.toString();
        final ctrDesc = TextEditingController();
        ctrDesc.text = char.description;

        return AlertDialog(
          title: const Text('Редактирование персонажа'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 466,
                child: TextField(
                  autofocus: true,
                  controller: ctrName,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Имя персонажа',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 230,
                    child: TextField(
                      autofocus: true,
                      controller: ctrRace,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Раса',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      autofocus: true,
                      controller: ctrClass,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Класс',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  SizedBox(
                    width: 230,
                    child: TextField(
                      autofocus: true,
                      controller: ctrHP,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'ХП',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      autofocus: true,
                      controller: ctrAR,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'КД',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      autofocus: true,
                      controller: ctrSTR,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Сила',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      autofocus: true,
                      controller: ctrAGL,
                      decoration: const InputDecoration(
                        labelText: 'Ловкость',
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      autofocus: true,
                      controller: ctrINT,
                      decoration: const InputDecoration(
                        labelText: 'Интеллект',
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      autofocus: true,
                      controller: ctrATL,
                      decoration: const InputDecoration(
                        labelText: 'Телосложение',
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      autofocus: true,
                      controller: ctrCAR,
                      decoration: const InputDecoration(
                        labelText: 'Харизма',
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      autofocus: true,
                      controller: ctrWIS,
                      decoration: const InputDecoration(
                        labelText: 'Мудрость',
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 466,
                child: TextField(
                  autofocus: true,
                  controller: ctrDesc,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final Character newChar = Character(
                  name: ctrName.text,
                  race: ctrRace.text,
                  crClass: ctrClass.text,
                  strength: int.parse(ctrSTR.text),
                  agility: int.parse(ctrAGL.text),
                  intelligence: int.parse(ctrINT.text),
                  athletics: int.parse(ctrATL.text),
                  charisma: int.parse(ctrCAR.text),
                  wisdom: int.parse(ctrWIS.text),
                  hp: int.parse(ctrHP.text),
                  hpModifier: int.parse(ctrHPMod.text),
                  kd: int.parse(ctrAR.text),
                  description: ctrDesc.text,
                  inventory: char.inventory,
                  spells: char.spells,
                  imageUrl: char.imageUrl,
                  isEnabled: char.isEnabled,
                );
                box.putAt(index, newChar);
                _updateScreen();
                ctrName.dispose();
                ctrRace.dispose();
                ctrClass.dispose();
                ctrHP.dispose();
                ctrHPMod.dispose();
                ctrAR.dispose();
                ctrSTR.dispose();
                ctrAGL.dispose();
                ctrINT.dispose();
                ctrATL.dispose();
                ctrCAR.dispose();
                ctrWIS.dispose();
                ctrDesc.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Готово'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _updateScreen() {
    onSave();
    print('Character added!');
  }
}
