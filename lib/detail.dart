import 'package:flutter/material.dart';
import 'package:prov/home.dart';
import 'package:prov/model.dart';

class DetailScreen extends StatelessWidget {
  final CompanyModel company;

  const DetailScreen(this.company);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
        actions: HomeScreen.buildActions(context),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(company.description != null ? company.description : ''),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.call),
      ),
    );
  }
}
