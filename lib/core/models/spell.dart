import 'package:hive_flutter/hive_flutter.dart';

part 'spell.g.dart';

@HiveType(typeId: 2)
class Spell extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int? dice;
  @HiveField(2)
  final int? dmg;
  @HiveField(3)
  final int? cast;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final int? castModifier;
  @HiveField(6)
  final int? energyOnCast;
  @HiveField(7)
  final String? energyDescription;

  Spell({
    required this.name,
    this.description,
    this.dmg,
    this.dice,
    this.cast,
    this.castModifier,
    this.energyOnCast,
    this.energyDescription,
  });
}
