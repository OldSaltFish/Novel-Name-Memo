import 'package:flutter_modular/flutter_modular.dart';
import 'package:novel_name_memo/pages/book/book_page.dart';
import 'package:novel_name_memo/pages/index_page.dart';


class IndexModule extends Module {
  @override
  void binds(i) {

  }

  @override
  void routes(r) {
    // r.module("/", module: HomePage());
    r.child('/', child: (context)=>IndexPage());
    r.child('/book',child: (context)=>BookPage());
  }
}

