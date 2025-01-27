import 'package:hive/hive.dart';
part 'book_item.g.dart';
@HiveType(typeId: 0)
class BookItem {
  // @HiveField(0)
  // String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String coverUri;

  BookItem({
    // required this.id,
    required this.name,
    required this.coverUri,
  });
  // BookItem(this.id,this.name,this.coverUri);
  @override
  String toString() {
    return 'BookItem{name: $name, coverUri: $coverUri}';
  }
}
