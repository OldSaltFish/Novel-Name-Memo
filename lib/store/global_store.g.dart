// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$_GlobalStore on _GlobalStoreBase, Store {
  late final _$booksAtom =
      Atom(name: '_GlobalStoreBase.books', context: context);

  @override
  List<BookItem> get books {
    _$booksAtom.reportRead();
    return super.books;
  }

  @override
  set books(List<BookItem> value) {
    _$booksAtom.reportWrite(value, super.books, () {
      super.books = value;
    });
  }

  late final _$_GlobalStoreBaseActionController =
      ActionController(name: '_GlobalStoreBase', context: context);

  @override
  void getBooks() {
    final _$actionInfo = _$_GlobalStoreBaseActionController.startAction(
        name: '_GlobalStoreBase.getBooks');
    try {
      return super.getBooks();
    } finally {
      _$_GlobalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteAllBooks() {
    final _$actionInfo = _$_GlobalStoreBaseActionController.startAction(
        name: '_GlobalStoreBase.deleteAllBooks');
    try {
      return super.deleteAllBooks();
    } finally {
      _$_GlobalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
books: ${books}
    ''';
  }
}
