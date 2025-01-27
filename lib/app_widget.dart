import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context){
    // 此处的标题根本看不到
    return MaterialApp.router(
        // title: 'My Smart App',
        // theme: ThemeData(primarySwatch: Colors.red),
        routerConfig: Modular.routerConfig,
    );
  }
}