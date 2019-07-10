import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';




class Editor extends StatefulWidget {
  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  File _image;

  getImageFile(ImageSource camera) async {
    var Image = await ImagePicker.pickImage(source: camera);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: Image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,

    );


    File result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 58,
      rotate: 180,
      minHeight: 100,
      minWidth: 100,
    );

    setState(() {
      _image = result;
      print(_image.lengthSync());
      debugPrint("corped ${croppedFile.lengthSync()}");
      debugPrint("result ${result.lengthSync()}");
    });
  }

  Widget build(BuildContext context) {
     print(_image?.lengthSync());
    return Scaffold(
        appBar: AppBar(
          title: Text("imageEditor"),
          centerTitle: true,
        ),
        body: Center(
            child: _image == null
                ? Text("image")
                : Image.file(
                    _image,
                    height: 200,
                    width: 200,
                  )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
                onPressed: () {
                  getImageFile(ImageSource.gallery);
                },
                label: Text("Gallory"),
                heroTag: UniqueKey(),
                icon: Icon(Icons.library_books)),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                getImageFile(ImageSource.camera);
                //var camera = ImagePicker.pickImage(source: ImageSource.camera);
              },
              label: Text("Camera"),
              heroTag: UniqueKey(),
              icon: Icon(Icons.camera_alt),
            ),

          ],
        ));
  }
}
