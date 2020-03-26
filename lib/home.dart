import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prov/client.dart';
import 'package:prov/detail.dart';
import 'package:prov/model.dart';
import 'package:prov/search.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('empresas.co.mz'),
        actions: buildActions(context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: PagewiseListView<CompanyModel>(
          pageSize: 20,
          pageFuture: (page) => fetchCompanies(page),
          itemBuilder: (_, company, __) => _buildTitle(context, company),
          loadingBuilder: (context) => SpinKitRipple(
            size: 35.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ));

  static List<Widget> buildActions(BuildContext context) => <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            var company =
                await showSearch(context: context, delegate: CompanySearch());
            if (company != null)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(company)));
          },
        )
      ];

  static Widget buildErrorView(Object error) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, size: 25.0),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  static Widget buildLeading(CompanyModel company) => (company.image == null)
      ? Container(
          width: 50.0,
          child: CircleAvatar(
            child: Text(company.name[0]),
          ),
        )
      : Image.network(
          company.image,
          width: 50.0,
        );

  Widget _buildTitle(context, CompanyModel company) => Column(
        children: <Widget>[
          ListTile(
            key: Key(company.id),
            leading: buildLeading(company),
            title: Text(company.name),
            subtitle: Text(company.addressOrCity),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailScreen(company))),
          ),
          Divider()
        ],
      );
}
