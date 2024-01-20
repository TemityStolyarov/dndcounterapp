// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeaponAdapter extends TypeAdapter<Weapon> {
  @override
  final int typeId = 1;

  @override
  Weapon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weapon(
      name: fields[0] as String,
      description: fields[1] as String?,
      dmg: fields[3] as int?,
      dice: fields[2] as int?,
      kd: fields[4] as int?,
      kdPierceBuff: fields[5] as int?,
      dmgBuff: fields[6] as int?,
      type: fields[7] as WeaponType?,
      amount: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Weapon obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dice)
      ..writeByte(3)
      ..write(obj.dmg)
      ..writeByte(4)
      ..write(obj.kd)
      ..writeByte(5)
      ..write(obj.kdPierceBuff)
      ..writeByte(6)
      ..write(obj.dmgBuff)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaponAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeaponTypeAdapter extends TypeAdapter<WeaponType> {
  @override
  final int typeId = 4;

  @override
  WeaponType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeaponType.usual;
      case 1:
        return WeaponType.passive;
      case 2:
        return WeaponType.active;
      case 3:
        return WeaponType.usedWhen;
      default:
        return WeaponType.usual;
    }
  }

  @override
  void write(BinaryWriter writer, WeaponType obj) {
    switch (obj) {
      case WeaponType.usual:
        writer.writeByte(0);
        break;
      case WeaponType.passive:
        writer.writeByte(1);
        break;
      case WeaponType.active:
        writer.writeByte(2);
        break;
      case WeaponType.usedWhen:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaponTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
