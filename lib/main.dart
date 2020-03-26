import 'package:flutter/material.dart';
import 'package:prov/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: HomeScreen(),
      );
}
