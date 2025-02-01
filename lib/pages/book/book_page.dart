import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;
import 'package:flutter/material.dart';
import 'package:novel_name_memo/models/homepage/book_item.dart';
import 'package:novel_name_memo/store/book_store.dart';
import 'package:provider/provider.dart';
import '../../components/img/cover_picker.dart';
import '../../models/homepage/book_character.dart';

/// 进入页面时的情景
enum _PageStateType { edit, add }
// class _Character{
//   final String name;
//   final List<String> relation;
//   _Character({required this.name, required this.relation});
// }

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<StatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late _PageStateType pageState;
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
    final Map? args = Modular.args.data;
    if (args != null) {
      BookItem book = args['book'];
      bookStore.isEdit = true;
      bookStore.bookIndex = args['index'];
      bookStore.name = book.name;
      bookStore.controller.text = book.name;
      bookStore.coverUri = book.coverUri;
    }
  }
}

class _BookBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookBodyState();
}

class _BookBodyState extends State<_BookBody> {
  List<TextEditingController> _nameControllers = [];
  late List<List<TextEditingController>> _relationControllers =
      []; // 添加: 用于处理角色关系的输入

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var bookStore = Provider.of<BookStore>(context, listen: false);
    if (Modular.args.data == null) return;
    final BookItem book = Modular.args.data['book'];
    debugPrint('book: ${book.hashCode}');
    debugPrint('dataBook: ${Modular.args.data['book'].hashCode}');
    bookStore.characters = book.characters;
    var characters = book.characters;
    _nameControllers = characters
        .map((item) => TextEditingController(text: item.name))
        .toList();
    // widget.items.map((item) => TextEditingController(text: item)).toList();
    _relationControllers = characters.map((item) {
      return item.relation.map((relation) {
        return TextEditingController(text: relation);
      }).toList();
    }).toList(); // 添加: 初始化角色关系的输入控制器
  }

  void addItem() {
    var bookStore = Provider.of<BookStore>(context, listen: false);
    debugPrint('addItem${bookStore.hashCode}');
    // 添加: 添加新项目的方法
    setState(() {
      bookStore.characters
          .add(BookCharacter(name: '未命名', coverUri: '', relation: []));
      debugPrint('setState: ${bookStore.characters}');
      _nameControllers.add(TextEditingController(text: '未命名'));
      _relationControllers.add([]); // 添加: 添加角色关系的输入控制器
    });
    debugPrint('setState外: ${bookStore.characters}');
  }

  // 添加: 添加新角色关系的方法
  void addRelation(int index) {
    var bookStore = Provider.of<BookStore>(context, listen: false);
    bookStore.characters[index].relation.add('');
    setState(() {
      _relationControllers[index]
          .add(TextEditingController()); // 修改: 将新关系输入框添加到列表末尾
    });
  }

  void removeRelation(int characterIndex, int relationIndex) {
    var bookStore = Provider.of<BookStore>(context, listen: false);
    setState(() {
      bookStore.characters[characterIndex].relation.removeAt(relationIndex);
      _relationControllers[characterIndex].removeAt(relationIndex);
    });
  }

  @override
  void dispose() {
    debugPrint('触发bookPage的销毁');
    super.dispose();
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    for (var controllerList in _relationControllers) {
      for (var controller in controllerList) {
        controller.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var bookStore = Provider.of<BookStore>(context, listen: false);
    var book = Modular.args.data;
    debugPrint('build里面的参数：${book.toString()}');
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch, // 修改: 将 crossAxisAlignment 从 start 改为 stretch，使 Column 占满 Row 的高度
          children: [
            CoverPicker(
              imgUri: bookStore.coverUri,
              onImageSelected: (path) {
                bookStore.coverUri = path;
                debugPrint('coverUri: ${bookStore.coverUri}');
              },
              width: 90,
              height: 120,
            ),
            Expanded(
                child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center, // 添加: 将 mainAxisAlignment 设置为 center，使内容垂直居中
                children: [
                  Observer(
                      builder: (_) => Text(
                            '书名: ${bookStore.name}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          )),
                  ElevatedButton(
                    onPressed: () {
                      bookStore.onSave();
                      Modular.to.pop();
                    },
                    child: const Text('保存'),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      Divider(),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: bookStore.characters.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CoverPicker(
                    imgUri: bookStore.characters[index].coverUri,
                    onImageSelected: (path) {
                      bookStore.characters[index].coverUri = path;
                    },
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _nameControllers[index],
                      onChanged: (value) {
                        bookStore.characters[index].name = value;
                        debugPrint(
                            'onChanged: ${bookStore.characters[index].name}');
                      },
                      decoration: InputDecoration(
                        hintText: '输入角色名称',
                        focusedBorder: OutlineInputBorder(), // 添加: 仅在获得焦点时显示边框
                        enabledBorder: InputBorder.none, // 添加: 失去焦点时不显示边框
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, textIndex) {
                          return Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _relationControllers[index][textIndex],
                                  // 添加: 角色关系输入框
                                  onChanged: (value) {
                                    bookStore.characters[index].relation[textIndex] =
                                        value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: '输入人物关系',
                                    border:
                                        OutlineInputBorder(), // 添加: 使用 OutlineInputBorder 设置外层方框
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  removeRelation(index, textIndex);
                                },
                              ),
                            ],
                          );
                        },
                        itemCount: _relationControllers[index].length),
                    // 添加: 添加按钮
                    ElevatedButton(
                      onPressed: () {
                        addRelation(index);
                      },
                      child: const Text('添加关系'),
                    ),
                  ],
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // 保存逻辑
              //     setState(() {
              //       widget.items[index] = _controllers[index].text;
              //     });
              //   },
              //   child: const Text('保存'),
              // ),
            ],
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
  @override
  Widget build(BuildContext context) {
    var bookStore = Provider.of<BookStore>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
              width: 300,
              // height: 200,
              // child: Observer(
              //     builder: (_) =>
              child: TextField(
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
                  bookStore.nameSaved();
                  debugPrint('编辑完成: name: ${bookStore.name}');
                },
              )),
        ),
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
