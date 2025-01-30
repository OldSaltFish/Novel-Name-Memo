import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:novel_name_memo/models/homepage/book_item.dart';
import 'package:novel_name_memo/store/global_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/homepage/book_character.dart';
import '../models/homepage/book_item.dart';
import 'package:uuid/uuid.dart';

part 'book_store.g.dart';
class BookStore = BookStoreBase with _$BookStore,ChangeNotifier;
// final globalStore = getGlobalStoreInstance();
abstract class BookStoreBase with Store{
  // 命名构造函数
  // BookViewModel._internal();
  // static final BookViewModel _instance = BookViewModel._internal(); // 私有静态实例
  // // BookItem bookItem = BookItem(id: id, name: name, coverUri: coverUri)
  // factory BookViewModel() {
  //   return _instance; // 返回已存在的实例
  // }
  final Box<BookItem> box = Hive.box('books');
  @observable
  bool isEditable = true;
  @observable
  String name = '';
  /// 页面是编辑还是新增
  bool isEdit = false;
  late int bookIndex;
  String coverUri = '';
  List<BookCharacter> characters = [];

  final TextEditingController controller = TextEditingController(text: '');
  final FocusNode focusNode = FocusNode();
  // String get name{
  //   return box.getAt(0)?.name ?? '未命名';
  //   // return box.get('name',defaultValue: '未命名');
  // }
  void init() async{

  }
  void onSave() async{
    // 根据页面状态来确定是要保存还是新增
    if(isEdit) {
      editBook();
    } else {
      await addBook();
    }
    globalStore.getBooks();
  }
  void editBook(){
    box.putAt(bookIndex, BookItem(name:name,coverUri:coverUri,characters: characters));
  }
  // 点保存时触发addBook
  Future<void> addBook() async {
    // debugPrint('addBook$hashCode');
    // box.deleteFromDisk();
    // var book = BookItem(id:globalStore.bookId.toString(),name:name,coverUri:coverUri);
    // debugPrint('characters: $characters');
    // globalStore.booksIdCount();

    // 如果books路径不存在，那么创建
    if(coverUri != ''){
      final directory = await getApplicationSupportDirectory();
      // 创建一个 Directory 实例
      var uuid = Uuid();
      final imgName = uuid.v4();
      final newImgPath = p.join(directory.path,'books','$imgName${p.extension(coverUri)}');
      final savedFile = File(newImgPath);
      File(coverUri).copy(savedFile.path);
      coverUri = newImgPath;
    }
    var book = BookItem(name:name,coverUri:coverUri,characters: characters);
    debugPrint('保存前的Book:$book');
    await box.add(book);
  }
  void edit() {
    isEditable = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }
  @action
  void nameSaved() {
    isEditable = false;
    name = controller.text;
    // box.put('name', controller.text);
    debugPrint('name为$name');
  }
  // void dispose() {
  //   controller.dispose();
  //   focusNode.dispose();
  // }
}

