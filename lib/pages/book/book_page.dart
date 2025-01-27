import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:novel_name_memo/models/homepage/book_item.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});
  @override
  State<StatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage>{
  late BookItem book;
  @override
  void initState() {
    super.initState();
    book = Modular.args.data;
    debugPrint('接受到参数: ${book.toString()}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Modular.to.navigate('/'),
          child: Text('Back to Home'),
        ),
      ),
    );
  }
}