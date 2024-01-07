// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charbook.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharBookAdapter extends TypeAdapter<CharBook> {
  @override
  final int typeId = 3;

  @override
  CharBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharBook(
      name: fields[0] as String,
      chars: (fields[1] as List).cast<Character>(),
      coins: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CharBook obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.chars)
      ..writeByte(2)
      ..write(obj.coins);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
