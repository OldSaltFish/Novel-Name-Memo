import 'package:flutter/material.dart';
// 暂时没必要
class CommonAppbar extends StatelessWidget{
  String title = '';
  final List<IconButton> iconButtons;
  CommonAppbar({super.key,required title, this.iconButtons=const [] });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Row(
          children: iconButtons,
        )
      ],
    );
    throw UnimplementedError();
  }

}