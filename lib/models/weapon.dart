import 'package:hive_flutter/hive_flutter.dart';

part 'weapon.g.dart';

@HiveType(typeId: 1)
class Weapon extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final int? dice;
  @HiveField(3)
  final int? dmg;
  @HiveField(4)
  final int? kd;

  Weapon({
    required this.name,
    this.description,
    this.dice,
    this.dmg,
    this.kd,
  });
}
