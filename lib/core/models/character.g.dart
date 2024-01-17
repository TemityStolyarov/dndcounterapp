// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 0;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      race: fields[1] as String,
      crClass: fields[2] as String,
      description: fields[11] as String,
      inventory: (fields[12] as List).cast<Weapon>(),
      spells: (fields[13] as List).cast<Spell>(),
      strength: fields[5] as int,
      agility: fields[6] as int,
      intelligence: fields[7] as int,
      athletics: fields[8] as int,
      charisma: fields[9] as int,
      wisdom: fields[10] as int,
      name: fields[0] as String,
      hp: fields[3] as int,
      kd: fields[4] as int,
      hpModifier: fields[14] as int,
      imageUrl: fields[15] as String,
      isEnabled: fields[16] as bool,
      statusKdDebuff: fields[17] as String?,
      statusKdBuff: fields[18] as String?,
      statusProvocated: fields[26] as String?,
      statusRoped: fields[19] as String?,
      statusDmgBuff: fields[20] as String?,
      statusFreezed: fields[21] as String?,
      statusRollBuff: fields[24] as String?,
      statusRollDebuff: fields[25] as String?,
      initiative: fields[22] as int?,
      initiativeBeforeBattle: fields[23] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.race)
      ..writeByte(2)
      ..write(obj.crClass)
      ..writeByte(3)
      ..write(obj.hp)
      ..writeByte(4)
      ..write(obj.kd)
      ..writeByte(5)
      ..write(obj.strength)
      ..writeByte(6)
      ..write(obj.agility)
      ..writeByte(7)
      ..write(obj.intelligence)
      ..writeByte(8)
      ..write(obj.athletics)
      ..writeByte(9)
      ..write(obj.charisma)
      ..writeByte(10)
      ..write(obj.wisdom)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.inventory)
      ..writeByte(13)
      ..write(obj.spells)
      ..writeByte(14)
      ..write(obj.hpModifier)
      ..writeByte(15)
      ..write(obj.imageUrl)
      ..writeByte(16)
      ..write(obj.isEnabled)
      ..writeByte(17)
      ..write(obj.statusKdDebuff)
      ..writeByte(18)
      ..write(obj.statusKdBuff)
      ..writeByte(19)
      ..write(obj.statusRoped)
      ..writeByte(20)
      ..write(obj.statusDmgBuff)
      ..writeByte(21)
      ..write(obj.statusFreezed)
      ..writeByte(22)
      ..write(obj.initiative)
      ..writeByte(23)
      ..write(obj.initiativeBeforeBattle)
      ..writeByte(24)
      ..write(obj.statusRollBuff)
      ..writeByte(25)
      ..write(obj.statusRollDebuff)
      ..writeByte(26)
      ..write(obj.statusProvocated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
