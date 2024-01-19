import 'package:hive_flutter/hive_flutter.dart';

part 'weapon.g.dart';

@HiveType(typeId: 4)
enum WeaponType {
  @HiveField(0)
  usual,
  @HiveField(1)
  passive,
  @HiveField(2)
  active,
  @HiveField(3)
  usedWhen;

  String toJson() => name;
  static WeaponType fromJson(String json) => values.byName(json);
}

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
  @HiveField(5)
  final int? kdPierceBuff;
  @HiveField(6)
  final int? dmgBuff;
  @HiveField(7)
  final WeaponType? type;
  @HiveField(8)
  final int? amount;

  Weapon({
    required this.name,
    this.description,
    this.dmg,
    this.dice,
    this.kd,
    this.kdPierceBuff,
    this.dmgBuff,
    this.type,
    this.amount,
  });

  Weapon copyWith({
    String? name,
    String? description,
    int? dice,
    int? dmg,
    int? kd,
    int? kdPierceBuff,
    int? dmgBuff,
    WeaponType? type,
    int? amount,
  }) =>
      Weapon(
        name: name ?? this.name,
        description: description ?? this.description,
        dice: dice ?? this.dice,
        dmg: dmg ?? this.dmg,
        kd: kd ?? this.kd,
        kdPierceBuff: kdPierceBuff ?? this.kdPierceBuff,
        dmgBuff: dmgBuff ?? this.dmgBuff,
        type: type ?? this.type,
        amount: amount ?? this.amount,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'dice': dice,
      'dmg': dmg,
      'kd': kd,
      'kdPierceBuff': kdPierceBuff,
      'dmgBuff': dmgBuff,
      'type': type == null ? WeaponType.usual.toJson() : type!.toJson(),
      'amount': amount,
    };
  }

  factory Weapon.fromJson(Map<String, dynamic> json) {
    var typeJson = json['type'] as dynamic;
    WeaponType typeParsed =
        typeJson != null ? WeaponType.fromJson(typeJson) : WeaponType.usual;
    return Weapon(
      name: json['name'],
      description: json['description'] ?? '',
      dice: json['dice'] ?? 0,
      dmg: json['dmg'] ?? 0,
      kd: json['kd'] ?? 0,
      kdPierceBuff: json['kdPierceBuff'] ?? 0,
      dmgBuff: json['dmgBuff'] ?? 0,
      type: typeParsed,
      amount: json['amount'] ?? 0,
    );
  }
}
