// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpellAdapter extends TypeAdapter<Spell> {
  @override
  final int typeId = 2;

  @override
  Spell read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spell(
      name: fields[0] as String,
      description: fields[4] as String?,
      dmg: fields[2] as int?,
      dice: fields[1] as int?,
      cast: fields[3] as int?,
      castModifier: fields[5] as int?,
      energyOnCast: fields[6] as int?,
      energyDescription: fields[7] as String?,
      type: fields[8] as SpellType?,
    );
  }

  @override
  void write(BinaryWriter writer, Spell obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dice)
      ..writeByte(2)
      ..write(obj.dmg)
      ..writeByte(3)
      ..write(obj.cast)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.castModifier)
      ..writeByte(6)
      ..write(obj.energyOnCast)
      ..writeByte(7)
      ..write(obj.energyDescription)
      ..writeByte(8)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpellTypeAdapter extends TypeAdapter<SpellType> {
  @override
  final int typeId = 5;

  @override
  SpellType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SpellType.usual;
      case 1:
        return SpellType.passive;
      case 2:
        return SpellType.active;
      case 3:
        return SpellType.usedWhen;
      case 4:
        return SpellType.mechanics;
      default:
        return SpellType.usual;
    }
  }

  @override
  void write(BinaryWriter writer, SpellType obj) {
    switch (obj) {
      case SpellType.usual:
        writer.writeByte(0);
        break;
      case SpellType.passive:
        writer.writeByte(1);
        break;
      case SpellType.active:
        writer.writeByte(2);
        break;
      case SpellType.usedWhen:
        writer.writeByte(3);
        break;
      case SpellType.mechanics:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
