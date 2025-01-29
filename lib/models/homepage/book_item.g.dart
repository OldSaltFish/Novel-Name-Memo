// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookItemAdapter extends TypeAdapter<BookItem> {
  @override
  final int typeId = 0;

  @override
  BookItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookItem(
      name: fields[1] as String,
      coverUri: fields[2] as String,
      characters: (fields[3] as List).cast<BookCharacter>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.coverUri)
      ..writeByte(3)
      ..write(obj.characters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
