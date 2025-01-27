import 'package:hive/hive.dart';
import 'package:novel_name_memo/store/global_store.dart';

import '../models/homepage/book_item.dart';

class NStorage{
  // static late final Box<BookItem> books;
  static Future init() async {
    Hive.registerAdapter(BookItemAdapter());
    // open不能定义在globalStore中，因为那里面需要用到box，因此作为成员变量
    // 成员变量中用不了await。
    await Hive.openBox<BookItem>('books');
    // Hive.openBox('booksId');
    globalStore.init();
  }
}