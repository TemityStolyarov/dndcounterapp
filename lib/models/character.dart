import 'package:dndcounterapp/models/spell.dart';
import 'package:dndcounterapp/models/weapon.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'character.g.dart';

@HiveType(typeId: 0)
class Character extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? race;
  @HiveField(2)
  final String? crClass;
  @HiveField(3)
  final int hp;
  @HiveField(4)
  final int kd;

  @HiveField(5)
  final int strength;
  @HiveField(6)
  final int agility;
  @HiveField(7)
  final int intelligence;
  @HiveField(8)
  final int athletics;
  @HiveField(9)
  final int charisma;
  @HiveField(10)
  final int wisdom;

  @HiveField(11)
  final String description;
  @HiveField(12)
  final List<Weapon> inventory;
  @HiveField(13)
  final List<Spell> spells;

  Character({
    this.race,
    this.crClass,
    required this.description,
    required this.inventory,
    required this.spells,
    required this.strength,
    required this.agility,
    required this.intelligence,
    required this.athletics,
    required this.charisma,
    required this.wisdom,
    required this.name,
    required this.hp,
    required this.kd,
  });
}
