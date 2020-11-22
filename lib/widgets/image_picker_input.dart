import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerInput extends StatefulWidget {
  @override
  _ImagePickerInputState createState() => _ImagePickerInputState();
}

class _ImagePickerInputState extends State<ImagePickerInput> {
  List<File> _images;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _images = [];
  }

  Future getImage() async {
    final file = await picker.getImage(source: ImageSource.gallery);
    setState(() => _images.add(File(file.path)));
  }

  // ignore: non_constant_identifier_names
  Widget _AddPhotoButton() {
    return RaisedButton(
      textColor: Colors.white,
      color: Colors.red[400],
      child: Text("PICK IMAGE"),
      onPressed: getImage,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _PhotoContainer() {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.25,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: const Color(0xffaabbcc).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.fromBorderSide(
            // #5c6bc0
            BorderSide(color: const Color(0xffaabbcc), width: 4.0),
          ),
        ),
        // child: Image.file(_images.first),
        // child: _Image(_images.first),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _Image(_images.first),
            _Image(_images.first),
            _Image(_images.first),
            _Image(_images.first),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Image(File image) {
    final side = MediaQuery.of(context).size.height * 0.24;

    return Card(
      child: Container(
        height: side,
        width: side,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.file(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: _images.isEmpty ? _AddPhotoButton() : _PhotoContainer(),
    );
  }
}
