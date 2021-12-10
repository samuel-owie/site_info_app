import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File _storedImage;

  Future<void>_takePicture() async {
    //1
  //   final ImagePicker  _picker = ImagePicker();
  //   final imageFile = await _picker.pickImage(source: source);

  //2
  // final ImagePicker  _picker = ImagePicker();
  // final imageFile = await _picker.getImage(source: source)

  //3
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      );
    if(imageFile ==null){
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory(); // for app data
    final fileName = path.basename(File(imageFile.path).path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          child: _storedImage != null
          ? Image.file(_storedImage, fit: BoxFit.cover, width: double.infinity,)
          : Text('No Image Taken', textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture, 
            //child: child,
          ),
        )
      ],
    );
  }
}