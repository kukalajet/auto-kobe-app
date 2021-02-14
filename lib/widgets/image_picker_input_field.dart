import 'dart:io';

import 'package:auto_kobe/styles/styles.dart';
import 'package:constant_repository/constant_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerInputField extends StatelessWidget {
  const ImagePickerInputField({
    @required this.images,
    @required this.addImage,
    @required this.removeImage,
  });

  final List<String> images;
  final Function(String) addImage;
  final Function(String) removeImage;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: images.isEmpty
          ? _buildAddButton(context)
          : _buildPhotosContainer(context, images),
    );
  }

  Future _addImage() async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: ImageSource.gallery);
    this.addImage(file.path);
  }

  Widget _buildAddButton(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0.0),
      child: ButtonTheme(
        height: 48.0,
        minWidth: width * 0.9,
        child: RaisedButton(
          onPressed: _addImage,
          child: Text(
            StringConstant.pickImage.toUpperCase(),
            style: textBodyStyleLight,
          ),
          color: ColorConstant.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
            side: BorderSide(color: ColorConstant.primaryVariant),
          ),
        ),
      ),
    );
  }

  Widget _buildInContainerAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: FlatButton(
        onPressed: _addImage,
        color: ColorConstant.success.withOpacity(0.5),
        textColor: Colors.white,
        child: Icon(Icons.add, size: 48.0),
        shape: CircleBorder(),
      ),
    );
  }

  Widget _buildImage(String path, Function onDelete) {
    return Stack(
      children: [
        Center(
          child: Card(
            child: Container(
              height: 200.0,
              width: 200.0,
              child: Image.file(File(path), fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 2.0,
          right: 2.0,
          child: IconButton(
            onPressed: () => onDelete(path),
            icon: Icon(
              Icons.close,
              size: 32.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosContainer(BuildContext context, List<String> images) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 240.0,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: ColorConstant.success.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.fromBorderSide(
          BorderSide(width: 4.0, color: ColorConstant.success.withOpacity(0.3)),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: images
            .asMap()
            .entries
            .map(
              (entry) => _buildImage(
                entry.value,
                removeImage,
              ),
            )
            .followedBy(images.length < 6 ? [_buildInContainerAddButton()] : [])
            .toList(),
      ),
    );
  }
}
