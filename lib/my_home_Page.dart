import 'package:flutter/material.dart';
import 'my_inputs_screen.dart';
import 'package:provider/provider.dart';
import 'classes.dart' as ima;
import 'details.dart';
import 'database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Navigator.pushNamed(context, MyInputScreen.routeName);
          },
          child: Icon(
            Icons.image,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    DataHelper.deleteData('user_image');
                  });
                },
                icon: Icon(Icons.delete))
          ],
          title: Text('My Gallary'),
        ),
        body: FutureBuilder(
          future:
              Provider.of<ima.ImageFile>(context, listen: false).fetchImage(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<ima.ImageFile>(
                  child: Center(child: Text('Start your Adding story')),
                  builder: (ctx, image, ch) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (ctx, i) => GridTile(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Detail.routeName,
                                    arguments: image.items[i].id!);
                              },
                              child: Image.file(
                                image.items[i].image!,
                                fit: BoxFit.cover,
                              ),
                            )),
                        footer: GridTileBar(
                          leading: Text(
                            image.items[i].title,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text('  '),
                          subtitle: Text(image.items[i].id!),
                        ),
                      ),
                      itemCount: image.items.length,
                    ),
                  ),
                ),
        ));
  }
}
