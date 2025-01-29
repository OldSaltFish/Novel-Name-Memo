import 'package:hive/hive.dart';

import 'book_character.dart';
part 'book_item.g.dart';
@HiveType(typeId: 0)
class BookItem {
  // @HiveField(0)
  // String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String coverUri;
  @HiveField(3)
  List<BookCharacter> characters;
  BookItem({
    // required this.id,
    required this.name,
    required this.coverUri,
    required this.characters,
  });
  // BookItem(this.id,this.name,this.coverUri);
  @override
  String toString() {
    return 'BookItem{name: $name, coverUri: $coverUri}';
  }
}
