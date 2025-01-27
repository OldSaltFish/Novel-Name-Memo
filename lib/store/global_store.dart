import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import '../models/homepage/book_item.dart';
import 'package:path/path.dart' as p;
part 'global_store.g.dart';
// 下面这两行负责提供单例
// final GlobalStore _instance = GlobalStore();
// GlobalStore getGlobalStoreInstance() => _instance;
// 只暴露实例
var globalStore = _GlobalStore();
class _GlobalStore = _GlobalStoreBase with _$_GlobalStore;
abstract class _GlobalStoreBase with Store{
  Box<BookItem> box = Hive.box('books');
  // Box idBox = Hive.box('booksId');
  @observable
  List<BookItem> books = [];
  int bookId = 0;
  void init() async{
    var directory = await getApplicationSupportDirectory();
    debugPrint('init处，软件目录: $directory');
    final dir = Directory(p.join(directory.path,"books"));
    debugPrint(dir.path);
    if(!dir.existsSync()){
      var result = await dir.create(recursive: true);
      debugPrint("创建books目录：$result");
    }
  }
  void booksIdCount(){
    bookId++;
    // idBox.put('id', bookId);
  }
  @action
  void getBooks(){
    books = box.values.toList();
    debugPrint('getbooks$books');
    // idBox.put('id', 1);
  }
  @action
  void deleteAllBooks (){
    box.clear();
    books = box.values.toList();
  }
}