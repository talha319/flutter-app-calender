import 'package:flutter/material.dart';
import 'package:universal_html/prefer_sdk/html.dart';


class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        final reader = new FileReader();

        reader.onLoadEnd.listen((e) {
//          _handleResult(reader.result);
        });
        reader.readAsDataUrl(file);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
