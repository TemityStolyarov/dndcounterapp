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

  Spell copyWith({
    String? name,
    String? description,
    int? dice,
    int? dmg,
    int? cast,
    int? castModifier,
    int? energyOnCast,
    String? energyDescription,
  }) =>
      Spell(
        name: name ?? this.name,
        description: description ?? this.description,
        dice: dice ?? this.dice,
        dmg: dmg ?? this.dmg,
        cast: cast ?? this.cast,
        castModifier: castModifier ?? this.castModifier,
        energyOnCast: energyOnCast ?? this.energyOnCast,
        energyDescription: energyDescription ?? this.energyDescription,
      );
}
