import 'package:hive/hive.dart';
part 'book_character.g.dart';
@HiveType(typeId: 1)
class BookCharacter {
  @HiveField(1)
  String name;
  @HiveField(2)
  List<String> relation;
  BookCharacter(this.name,this.relation);
  @override
  String toString() {
    return 'BookCharacter{name: $name, relation: $relation}';
  }
}


