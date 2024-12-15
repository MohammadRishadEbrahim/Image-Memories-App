import 'package:flutter/material.dart';
import 'image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'classes.dart';

class MyInputScreen extends StatefulWidget {
  static const routeName = 'MyInputScreen';
  const MyInputScreen({super.key});

  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _storyController = TextEditingController();
  File? savedImage;

  void savedImages(File image) {
    savedImage = image;
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _storyController.text.isEmpty ||
        savedImage == null) {
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleController.text, _storyController.text, savedImage!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs Page'),
        actions: [
          IconButton(
            onPressed: onSave,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _storyController,
              decoration: InputDecoration(labelText: 'Story'),
            ),
            SizedBox(
              height: 40,
            ),
            ImageInput(savedImages),
          ],
        ),
      ),
    );
  }
}
