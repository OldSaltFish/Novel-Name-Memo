import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 用于选择封面图片
/// 目前暂时没有写大小选择功能
class CoverPicker extends StatefulWidget {
  /// 图片地址
  final String imgUri;
  /// 参数是选中的图片地址
  final Function(String)? onImageSelected;
  const CoverPicker({super.key, required this.imgUri,this.onImageSelected});

  @override
  State<CoverPicker> createState() => _CoverPickerState();
}

class _CoverPickerState extends State<CoverPicker> {
  File? _image; // 用于存储选择的图片文件
  late final String _imgUri;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery); // 从图库选择
      // final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera); // 使用相机拍照
      // File(picked  File!.path).copy()

      setState(() {
        _image = File(pickedFile!.path);
      });
      widget.onImageSelected?.call(pickedFile!.path);
    } catch (e) {
      debugPrint('Error picking image: $e');
      // 可以添加错误处理逻辑，例如显示一个 SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  @override
  void initState() {
    _imgUri = widget.imgUri;
    super.initState();
    if(_imgUri!=''){
      _image = File(_imgUri);
    }
  }
  // 大小，默认图片，存图片地址的变量
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: _pickImage,
            child: Column(
              children: [
                if (_image != null)
                  Image.file(
                    _image!,
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover, // 设置图片填充方式
                  )
                else
                  Image.asset(
                    'assets/images/defaultbook.jpeg', // 图片路径
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
              ],
            )),
      ],
    );
  }
}
