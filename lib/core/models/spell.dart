import 'package:hive_flutter/hive_flutter.dart';

part 'spell.g.dart';

@HiveType(typeId: 5)
enum SpellType {
  @HiveField(0)
  usual,
  @HiveField(1)
  passive,
  @HiveField(2)
  active,
  @HiveField(3)
  usedWhen,
  @HiveField(4)
  mechanics;

  String toJson() => name;
  static SpellType fromJson(String json) => values.byName(json);
}

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
  @HiveField(8)
  final SpellType? type;

  Spell({
    required this.name,
    this.description,
    this.dmg,
    this.dice,
    this.cast,
    this.castModifier,
    this.energyOnCast,
    this.energyDescription,
    this.type,
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
    SpellType? type,
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
        type: type ?? this.type,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'dice': dice,
      'dmg': dmg,
      'cast': cast,
      'castModifier': castModifier,
      'energyOnCast': energyOnCast,
      'energyDescription': energyDescription,
      'type': type == null ? SpellType.usual.toJson() : type!.toJson(),
    };
  }

  factory Spell.fromJson(Map<String, dynamic> json) {
    var typeJson = json['type'] as dynamic;
    SpellType typeParsed =
        typeJson != null ? SpellType.fromJson(typeJson) : SpellType.usual;

    return Spell(
      name: json['name'],
      description: json['description'] ?? '',
      dice: json['dice'] ?? 0,
      dmg: json['dmg'] ?? 0,
      cast: json['cast'] ?? 0,
      castModifier: json['castModifier'] ?? 0,
      energyOnCast: json['energyOnCast'] ?? 0,
      energyDescription: json['energyDescription'] ?? '',
      type: typeParsed,
    );
  }
}
