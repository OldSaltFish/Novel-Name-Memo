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

class _BookPageState extends State<BookPage> {
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
        child: SingleChildScrollView(
          // 修改: 使用 SingleChildScrollView 包裹整个内容区域
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [_EditableAppBar(), _BookBody()],
            // children: [Text('测试')],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BookItem? book = Modular.args.data;
    if (book != null) {
      bookStore.name = book.name;
      bookStore.controller.text = book.name;
      bookStore.coverUri = book.coverUri;
    }
  }
}

class _BookBody extends StatefulWidget {
  final List<String> items = ['角色1', '角色2', '角色3'];

  @override
  State<StatefulWidget> createState() => _BookBodyState();
}

class _BookBodyState extends State<_BookBody> {
  late List<TextEditingController> _controllers;
  late TextEditingController _newItemController; // 添加: 用于处理新项目的输入

  @override
  void initState() {
    super.initState();
    _controllers =
        widget.items.map((item) => TextEditingController(text: item)).toList();
    _newItemController = TextEditingController(); // 添加: 初始化新项目的输入控制器
  }

  void addItem() {
    // 添加: 添加新项目的方法
    setState(() {
      widget.items.add(_newItemController.text);
      _controllers.add(TextEditingController(text: _newItemController.text));
      _newItemController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var bookStore = Provider.of<BookStore>(context);
    var book = Modular.args.data;
    debugPrint('build里面的参数：${book.toString()}');
    return Column(children: [
      CoverPicker(
        imgUri: bookStore.coverUri,
        onImageSelected: (path) {
          bookStore.coverUri = path;
          debugPrint('coverUri: ${bookStore.coverUri}');
        },
      ),
      Observer(
          builder: (_) => Text(
                'Name: ${bookStore.name}',
              )),
      ElevatedButton(
        onPressed: () {
          bookStore.addBook();
          Modular.to.pop();
        },
        child: const Text('保存'),
      ),
      Text('角色'),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            // 修改: 使用 ListTile 美化项目项
            title: TextField(
              controller: _controllers[index],
              decoration: InputDecoration(
                hintText: '输入角色名称',
                border:
                    OutlineInputBorder(), // 添加: 使用 OutlineInputBorder 设置外层方框
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // 保存逻辑
                setState(() {
                  widget.items[index] = _controllers[index].text;
                });
              },
              child: const Text('保存'),
            ),
          );
        },
      ),
      FloatingActionButton(
        // 添加: 添加新项目的按钮
        onPressed: addItem,
        child: const Icon(Icons.add),
      ),
    ]);
  }
}

// 顶栏
class _EditableAppBar extends StatelessWidget {
  const _EditableAppBar({super.key});

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
                        decoration: InputDecoration(
                          hintText: '点击右侧编辑按钮输入名称...',
                          border:
                              OutlineInputBorder(), // 添加: 使用 OutlineInputBorder 设置外层方框
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
