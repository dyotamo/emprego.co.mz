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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (company.image != null)
              Center(
                child: Image.network(
                  company.image,
                  width: 150.0,
                  height: 150.0,
                ),
              ),
            Expanded(
              child: ListView(
                children: _buildDetailitems(context),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.call),
      ),
    );
  }

  List<Widget> _buildDetailitems(BuildContext context) => [
        ListTile(
          leading: Icon(Icons.category),
          title: Text(company.category),
        ),
        if (company.address != null)
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(company.address),
          ),
        if (company.city != null)
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text(company.city),
          ),
        if (company.address != null)
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(company.phone),
          ),
        if (company.phone != null)
          ListTile(
            leading: Icon(Icons.description),
            title: Text(company.description),
          ),
      ];
}
