import 'dart:io';

import 'package:auto_kobe/blocs/forms/forms.dart';
import 'package:auto_kobe/styles/styles.dart';
import 'package:constant_repository/constant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerInput extends StatefulWidget {
  @override
  _ImagePickerInputState createState() => _ImagePickerInputState();
}

class _ImagePickerInputState extends State<ImagePickerInput> {
  // List<File> _images;
  // final picker = ImagePicker();

  // @override
  // void initState() {
  //   super.initState();
  //   _images = [];
  // }

  Future _getImage() async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: ImageSource.gallery);
    final bloc = context.read<ThirdFormBloc>().state.images;
    final images =
        bloc != null ? (bloc.value != null ? bloc.value : []) : List<String>();
    context
        .read<ThirdFormBloc>()
        .add(ListingImagesChanged(images..add(file.path)));
  }

  // ignore: non_constant_identifier_names
  Widget _AddPhotoButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 48.0,
        child: RaisedButton(
          onPressed: _getImage,
          child: Text(
            "PICK IMAGE",
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

  // ignore: non_constant_identifier_names
  Widget _PhotoContainer({List<String> images}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        // height: size.height * 0.3,
        height: 240.0,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: ColorConstant.success.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.fromBorderSide(
            BorderSide(
              width: 4.0,
              color: ColorConstant.success.withOpacity(0.3),
            ),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: images
              .asMap()
              .entries
              .map((entry) => _Image(entry.value, () {
                    setState(() {
                      images.removeAt(entry.key);
                      images = [...images];
                    });
                  }))
              .followedBy(images.length < 6 ? [_AddImageButton()] : [])
              .toList(),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Image(String path, Function onDelete) {
    return Stack(
      children: [
        Center(
          child: Card(
            child: Container(
              height: 200.0,
              width: 200.0,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 2.0,
          right: 2.0,
          child: IconButton(
            icon: Icon(
              Icons.close,
              size: 32.0,
            ),
            onPressed: () => onDelete(),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _AddImageButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: FlatButton(
        onPressed: _getImage,
        color: ColorConstant.success.withOpacity(0.5),
        textColor: Colors.white,
        child: Icon(Icons.add, size: 48.0),
        shape: CircleBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdFormBloc, ThirdFormState>(
      buildWhen: (previous, current) => previous.images != current.images,
      builder: (context, state) {
        var images = List<String>();
        if (state.images != null) images.addAll(state.images.value);

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),

          // TODO: Instead of calling _images, call bloc.
          child: images.isEmpty
              ? _AddPhotoButton()
              : _PhotoContainer(images: images),
        );
      },
    );
  }
}
