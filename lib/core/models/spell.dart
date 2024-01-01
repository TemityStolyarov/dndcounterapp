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
  final int? cost;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final int? costModifier;

  Spell({
    required this.name,
    this.description,
    this.dmg,
    this.dice,
    this.cost,
    this.costModifier,
  });
}
