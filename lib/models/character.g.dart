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
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.imageUrl);
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
