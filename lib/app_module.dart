import 'package:flutter_modular/flutter_modular.dart';
import 'package:novel_name_memo/pages/index_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {

  }

  @override
  void routes(r) {
    r.module("/", module: IndexModule());
  }
}