import 'package:dndcounterapp/core/models/character.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterAddModal {
  final Box box;
  final VoidCallback onAdd;

  CharacterAddModal({
    required this.box,
    required this.onAdd,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ctrName = TextEditingController();
        final ctrRace = TextEditingController();
        final ctrClass = TextEditingController();
        final ctrSTR = TextEditingController();
        final ctrAGL = TextEditingController();
        final ctrINT = TextEditingController();
        final ctrATL = TextEditingController();
        final ctrCAR = TextEditingController();
        final ctrWIS = TextEditingController();
        final ctrDesc = TextEditingController();

        return AlertDialog(
          title: const Text('Добавление персонажа'),
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
                  hp: int.parse(ctrSTR.text),
                  hpModifier: 0,
                  kd: 10,
                  description: ctrDesc.text,
                  inventory: [],
                  spells: [],
                  imageUrl: '',
                  isEnabled: true,
                );
                box.add(newChar);
                _updateScreen();
                ctrName.dispose();
                ctrRace.dispose();
                ctrClass.dispose();
                ctrSTR.dispose();
                ctrAGL.dispose();
                ctrINT.dispose();
                ctrATL.dispose();
                ctrCAR.dispose();
                ctrWIS.dispose();
                ctrDesc.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
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
    onAdd();
    print('Character added!');
  }
}