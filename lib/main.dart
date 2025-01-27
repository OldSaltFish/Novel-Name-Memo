import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:novel_name_memo/app_module.dart';
import 'package:novel_name_memo/app_widget.dart';
import 'package:novel_name_memo/models/homepage/book_item.dart';
import 'package:novel_name_memo/utils/storage.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  try {
    await Hive.initFlutter(
        '${(await getApplicationSupportDirectory()).path}${Platform.pathSeparator}hive');
    // hive数据库初始化
    await NStorage.init();
  } catch (_) {
    // runApp(MaterialApp(
    // title: '初始化失败',
    // builder: (context, child) {
    // return const StorageErrorPage();
    // }));
    return;
  }
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
