import 'package:empresas.co.mz/widgets/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomeScreen(),
      );
}
