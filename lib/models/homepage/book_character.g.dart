// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookCharacterAdapter extends TypeAdapter<BookCharacter> {
  @override
  final int typeId = 1;

  @override
  BookCharacter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookCharacter(
      fields[1] as String,
      (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookCharacter obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.relation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookCharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
