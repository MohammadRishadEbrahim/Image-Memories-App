import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class Image {
  String? id;
  late String title;
  late String story;
  File? image;

  Image({this.image, required this.title, this.id, required this.story});
}

class ImageFile with ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [..._items];
  }

  Future<void> addImagePlace(String title, String story, File image) async {
    final newImage = Image(
        image: image,
        title: title,
        id: DateTime.now().toString(),
        story: story);
    _items.add(newImage);
    notifyListeners();
    DataHelper.insert('user_image', {
      'id': newImage.id!,
      'title': newImage.title,
      'image': newImage.image!.path,
      'story': newImage.story
    });
  }

  Image findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fetchImage() async {
    final list = await DataHelper.getData('user_image');
    _items = list
        .map(
          (item) => Image(
              image: File(item['image']),
              title: item['title'],
              id: item['id'],
              story: item['story']),
        )
        .toList();
  }
}
