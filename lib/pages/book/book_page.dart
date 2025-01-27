import 'dart:io';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novel_name_memo/models/homepage/book_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:novel_name_memo/store/book_store.dart';
import 'package:provider/provider.dart';

import '../../components/img/cover_picker.dart';


class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<StatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage>{
  final bookStore = BookStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: ChangeNotifierProvider<BookStore>(
        create: (_) => bookStore,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            EditableAppBar(),
            BookBody(),
          ],
          // children: [Text('测试')],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BookItem? book = Modular.args.data;
    if(book != null){
      bookStore.name = book.name;
      bookStore.controller.text = book.name;
      bookStore.coverUri = book.coverUri;
    }
  }
}


class BookBody extends StatelessWidget {
  const BookBody({super.key});

  @override
  Widget build(BuildContext context) {
    var bookStore = Provider.of<BookStore>(context);
    var book =  Modular.args.data;
    debugPrint('build里面的参数：${book.toString()}');
    return Column(children: [
      CoverPicker(imgUri: bookStore.coverUri,onImageSelected: (path){
        bookStore.coverUri = path;
        debugPrint('coverUri: ${bookStore.coverUri}');
      },),
      Observer(
          builder: (_) => Text(
                'Name: ${bookStore.name}',
              )),
      ElevatedButton(
        onPressed: () {
          bookStore.addBook();
          Modular.to.pop();
          // 保存信息
          // var bookViewModel = BookViewModel();
          // bookViewModel.addBook('111', '222');
          // IndexViewModel().refresh();
          // bookViewModel.name = '流浪地球';
        },
        child: const Text('保存'),
      ),
      Text('角色'),
      // 角色卡
      // ListView.builder(itemBuilder: itemBuilder)
      // Card(
      //     child: Row(
      //         children: [
      //           Text('角色卡'),
      //         ]
      //     )
      // )
    ]);
  }
}



// 顶栏
class EditableAppBar extends StatelessWidget {
  const EditableAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var bookStore = Provider.of<BookStore>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 300,
              // height: 200,
              child: Observer(
                  builder: (_) => TextField(
                    controller: bookStore.controller,
                    style: TextStyle(
                      color: Colors.black, // 根据启用状态设置颜色
                    ),
                    decoration: const InputDecoration(
                      hintText: '点击右侧编辑按钮输入名称...',
                      // 没有获得焦点时的样式：不显示下划线
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.transparent)),
                      disabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.transparent)),
                      // 获得焦点时的样式：显示默认下划线
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blue), // 可以自定义颜色
                      ),
                    ),
                    focusNode: bookStore.focusNode,
                    enabled: bookStore.isEditable,
                    onEditingComplete: () {
                      bookStore.saved();
                      debugPrint('编辑完成: name: ${bookStore.name}');
                    },
                  )),
            )),
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: '编辑',
          onPressed: () {
            bookStore.edit();
          },
        )
        // 其他UI元素，例如编辑和保存按钮
      ],
    );
  }
}
