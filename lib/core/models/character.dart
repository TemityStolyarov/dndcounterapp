import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'character.g.dart';

@HiveType(typeId: 0)
class Character extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String race;
  @HiveField(2)
  final String crClass;
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

  @HiveField(14)
  final int hpModifier;
  @HiveField(15)
  final String imageUrl;

  @HiveField(16)
  final bool isEnabled;

  @HiveField(17)
  final String? statusKdDebuff;
  @HiveField(18)
  final String? statusKdBuff;
  @HiveField(19)
  final String? statusRoped;
  @HiveField(20)
  final String? statusDmgBuff;
  @HiveField(21)
  final String? statusFreezed;
  @HiveField(22)
  final int? initiative;
  @HiveField(23)
  final int? initiativeBeforeBattle;

  @HiveField(24)
  final String? statusRollBuff;
  @HiveField(25)
  final String? statusRollDebuff;

  Character({
    required this.race,
    required this.crClass,
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
    required this.hpModifier,
    required this.imageUrl,
    required this.isEnabled,
    required this.statusKdDebuff,
    required this.statusKdBuff,
    required this.statusRoped,
    required this.statusDmgBuff,
    required this.statusFreezed,
    required this.statusRollBuff,
    required this.statusRollDebuff,
    required this.initiative,
    required this.initiativeBeforeBattle,
  });

  Character.empty({
    this.race = '',
    this.crClass = '',
    this.description = '',
    this.inventory = const [],
    this.spells = const [],
    this.strength = 0,
    this.agility = 0,
    this.intelligence = 0,
    this.athletics = 0,
    this.charisma = 0,
    this.wisdom = 0,
    this.name = '',
    this.hp = 0,
    this.hpModifier = 0,
    this.kd = 0,
    this.imageUrl = '',
    this.isEnabled = true,
    this.statusKdDebuff = '',
    this.statusKdBuff = '',
    this.statusRoped = '',
    this.statusDmgBuff = '',
    this.statusFreezed = '',
    this.statusRollBuff = '',
    this.statusRollDebuff = '',
    this.initiative = 0,
    this.initiativeBeforeBattle = 0,
  });

  Character copyWith({
    String? name,
    String? race,
    String? crClass,
    int? hp,
    int? kd,
    int? strength,
    int? agility,
    int? intelligence,
    int? athletics,
    int? charisma,
    int? wisdom,
    String? description,
    List<Weapon>? inventory,
    List<Spell>? spells,
    int? hpModifier,
    String? imageUrl,
    bool? isEnabled,
    String? statusKdDebuff,
    String? statusKdBuff,
    String? statusRoped,
    String? statusDmgBuff,
    String? statusFreezed,
    String? statusRollBuff,
    String? statusRollDebuff,
    int? initiative,
    int? initiativeBeforeBattle,
  }) =>
      Character(
        race: race ?? this.race,
        crClass: crClass ?? this.crClass,
        description: description ?? this.description,
        inventory: inventory ?? this.inventory,
        spells: spells ?? this.spells,
        strength: strength ?? this.strength,
        agility: agility ?? this.agility,
        intelligence: intelligence ?? this.intelligence,
        athletics: athletics ?? this.athletics,
        charisma: charisma ?? this.charisma,
        wisdom: wisdom ?? this.wisdom,
        name: name ?? this.name,
        hp: hp ?? this.hp,
        kd: kd ?? this.kd,
        hpModifier: hpModifier ?? this.hpModifier,
        imageUrl: imageUrl ?? this.imageUrl,
        isEnabled: isEnabled ?? this.isEnabled,
        statusKdDebuff: statusKdDebuff ?? this.statusKdDebuff,
        statusKdBuff: statusKdBuff ?? this.statusKdBuff,
        statusRoped: statusRoped ?? this.statusRoped,
        statusDmgBuff: statusDmgBuff ?? this.statusDmgBuff,
        statusFreezed: statusFreezed ?? this.statusFreezed,
        statusRollBuff: statusRollBuff ?? this.statusRollBuff,
        statusRollDebuff: statusRollDebuff ?? this.statusRollDebuff,
        initiative: initiative ?? this.initiative,
        initiativeBeforeBattle:
            initiativeBeforeBattle ?? this.initiativeBeforeBattle,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'race': race,
      'crClass': crClass,
      'hp': hp,
      'kd': kd,
      'strength': strength,
      'agility': agility,
      'intelligence': intelligence,
      'athletics': athletics,
      'charisma': charisma,
      'wisdom': wisdom,
      'description': description,
      'inventory': inventory.map((item) => item.toJson()).toList(),
      'spells': spells.map((spell) => spell.toJson()).toList(),
      'hpModifier': hpModifier,
      'imageUrl': imageUrl,
      'isEnabled': isEnabled,
      'statusKdDebuff': statusKdDebuff ?? '',
      'statusKdBuff': statusKdBuff ?? '',
      'statusRoped': statusRoped ?? '',
      'statusDmgBuff': statusDmgBuff ?? '',
      'statusFreezed': statusFreezed ?? '',
      'statusRollBuff': statusRollBuff ?? '',
      'statusRollDebuff': statusRollDebuff ?? '',
      'initiative': initiative,
      'initiativeBeforeBattle': initiativeBeforeBattle ?? 0,
    };
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    var weaponsJson = json['inventory'] as List<dynamic>?;
    List<Weapon> weaponParsed = weaponsJson != null
        ? weaponsJson.map((weaponJson) => Weapon.fromJson(weaponJson)).toList()
        : [];

    var spellsJson = json['spells'] as List<dynamic>?;
    List<Spell> spellsParsed = spellsJson != null
        ? spellsJson.map((spellJson) => Spell.fromJson(spellJson)).toList()
        : [];

    return Character(
      name: json['name'],
      race: json['race'],
      crClass: json['crClass'],
      hp: json['hp'],
      kd: json['kd'],
      strength: json['strength'],
      agility: json['agility'],
      intelligence: json['intelligence'],
      athletics: json['athletics'],
      charisma: json['charisma'],
      wisdom: json['wisdom'],
      description: json['description'],
      inventory: weaponParsed,
      spells: spellsParsed,
      hpModifier: json['hpModifier'],
      imageUrl: json['imageUrl'],
      isEnabled: json['isEnabled'],
      statusKdDebuff: json['statusKdDebuff'],
      statusKdBuff: json['statusKdBuff'],
      statusRoped: json['statusRoped'],
      statusDmgBuff: json['statusDmgBuff'],
      statusFreezed: json['statusFreezed'],
      statusRollBuff: json['statusRollBuff'],
      statusRollDebuff: json['statusRollDebuff'],
      initiative: json['initiative'],
      initiativeBeforeBattle: json['initiativeBeforeBattle'],
    );
  }
}
