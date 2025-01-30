import 'package:hive/hive.dart';
part 'book_character.g.dart';
@HiveType(typeId: 1)
class BookCharacter {
  @HiveField(1)
  String name;
  @HiveField(2)
  String coverUri;
  @HiveField(3)
  List<String> relation;
  BookCharacter({
    required this.name,
    required this.coverUri,
    required this.relation,
  });

  @override
  String toString() {
    return 'BookCharacter{name: $name, coverUri: $coverUri, relation: $relation}';
  }
}


