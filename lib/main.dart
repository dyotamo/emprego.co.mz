import 'package:flutter/material.dart';
import 'package:prov/home.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.teal),
        home: Scaffold(
          appBar: AppBar(
            title: Text('empresas.co.mz'),
          ),
          body: HomeScreen(),
        ));
  }
}
