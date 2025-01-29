// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookStore on BookStoreBase, Store {
  late final _$isEditableAtom =
      Atom(name: 'BookStoreBase.isEditable', context: context);

  @override
  bool get isEditable {
    _$isEditableAtom.reportRead();
    return super.isEditable;
  }

  @override
  set isEditable(bool value) {
    _$isEditableAtom.reportWrite(value, super.isEditable, () {
      super.isEditable = value;
    });
  }

  late final _$nameAtom = Atom(name: 'BookStoreBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$BookStoreBaseActionController =
      ActionController(name: 'BookStoreBase', context: context);

  @override
  void nameSaved() {
    final _$actionInfo = _$BookStoreBaseActionController.startAction(
        name: 'BookStoreBase.nameSaved');
    try {
      return super.nameSaved();
    } finally {
      _$BookStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEditable: ${isEditable},
name: ${name}
    ''';
  }
}
