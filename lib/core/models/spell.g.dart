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
    );
  }

  @override
  void write(BinaryWriter writer, Spell obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.energyDescription);
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
