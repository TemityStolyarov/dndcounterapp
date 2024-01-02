import 'package:hive_flutter/hive_flutter.dart';

part 'weapon.g.dart';

@HiveType(typeId: 1)
class Weapon extends HiveObject {
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
    this.dmg,
    this.dice,
    this.kd,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'dice': dice,
      'dmg': dmg,
      'kd': kd,
    };
  }

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      name: json['name'],
      description: json['description'],
      dice: json['dice'],
      dmg: json['dmg'],
      kd: json['kd'],
    );
  }
}
