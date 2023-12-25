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

  Spell({
    this.cost,
    this.dice,
    this.dmg,
    this.description,
    required this.name,
  });
}
