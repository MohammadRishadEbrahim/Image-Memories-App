import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_home_Page.dart';
import 'my_inputs_screen.dart';
import 'details.dart';
import 'classes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ImageFile(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'Gallary App',
        home: MyHomePage(),
        routes: {
          MyInputScreen.routeName: (ctx) => MyInputScreen(),
          Detail.routeName: (ctx) => Detail(),
        },
      ),
    );
  }
}
