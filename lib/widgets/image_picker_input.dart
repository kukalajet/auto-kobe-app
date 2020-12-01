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
      color: const Color(0xffaabbcc),
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
        height: size.height * 0.3,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: const Color(0xffaabbcc).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.fromBorderSide(
            BorderSide(color: const Color(0xffaabbcc), width: 4.0),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: _images
              .asMap()
              .entries
              .map((entry) => _Image(entry.value, () {
                    setState(() {
                      _images.removeAt(entry.key);
                      _images = [..._images];
                    });
                  }))
              .followedBy(_images.length < 6 ? [_AddImageButton()] : [])
              .toList(),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Image(File image, Function onDelete) {
    final side = MediaQuery.of(context).size.height * 0.24;

    return Stack(
      children: [
        Card(
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
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              onDelete();
            },
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _AddImageButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: getImage,
        style: ElevatedButton.styleFrom(
          primary: const Color(0xffaabbcc),
          shape: CircleBorder(),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Icon(Icons.add),
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
