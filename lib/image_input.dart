import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function imagesaveat;
  ImageInput(this.imagesaveat);
  // const ImageInput({super.key, this.imagesaveat});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  Future _takePicture() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 600);
    if (image == null) return;
    final imagePermanently = await saveFilePermanently(image.path);
    setState(() {
      this._imageFile = imagePermanently;
    });
    widget.imagesaveat(imagePermanently);
  }

  Future<void> _getgallary() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (image == null) return;
    final imagePermanently = await saveFilePermanently(image.path);
    setState(() {
      this._imageFile = imagePermanently;
    });
    widget.imagesaveat(imagePermanently);
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await syspath.getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.deepOrange)),
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                )
              : Center(child: Text('No Image yet Add')),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            TextButton.icon(
              onPressed: _getgallary,
              icon: Icon(Icons.image),
              label: Text('Add Your Image'),
            ),
            TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera),
              label: Text('Take a Picture'),
            ),
          ],
        ),
      ],
    );
  }
}
