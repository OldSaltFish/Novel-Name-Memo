import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:novel_name_memo/store/global_store.dart';
import '../models/homepage/book_item.dart';
import 'package:path/path.dart' as p;
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('index初始化');
    globalStore.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('小说记名器'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: '添加',
              onPressed: () {
                Modular.to.pushNamed('/book');
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: '删除全部',
              onPressed: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
                globalStore.deleteAllBooks();
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: '设置',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        body: Observer(builder: (context) {
          return Wrap(
              children: (globalStore
                  .books
                  .map((bookItem) => BookCoverWidget(book: bookItem))).toList());
        }));
  }
}

class BookCoverWidget extends StatelessWidget {
  final BookItem book;
  const BookCoverWidget({super.key,required this.book});
  // const BookCoverWidget({Key? key}){
  //
  // };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击事件处理
        Modular.to.pushNamed('/book',arguments: book);
      },
      child: Column(
        children: <Widget>[
          Card(
              clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: Column(
                children: [
                  Container(
                    width: 140, // 容器的固定宽度
                    height: 200, // 容器的固定高度
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: AssetImage(book.coverUri==''?'assets/images/defaultbook.jpeg':book.coverUri),
                        image: book.coverUri==''?AssetImage('assets/images/defaultbook.jpeg')
                            :FileImage(File(book.coverUri)),
                        // 本地图片路径
                        fit: BoxFit.cover, // 填充模式，cover表示覆盖整个容器，必要时进行裁剪
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Text(bookViewModel.books[index].name),
                  Text(book.name)
                ],
              )),
        ],
      ),
    );
  }
}
