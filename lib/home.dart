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
        child: PagewiseGridView.count(
          crossAxisCount: 2,
          pageSize: 20,
          pageFuture: (page) => fetchCompanies(page),
          itemBuilder: (_, company, __) => _buildTitle(context, company),
          loadingBuilder: (context) => _buildLoading(context),
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

  static Widget buildThumnail(context, CompanyModel company) => Padding(
        padding: EdgeInsets.all(8.0),
        child: (company.image == null)
            ? _buildCircleAvatar(company)
            : _buildImageThumb(company, context),
      );

  static Widget _buildImageThumb(CompanyModel company, context) =>
      Image.network(
        company.image,
        width: 60.0,
        loadingBuilder: (_, child, event) {
          if (event == null) return child;
          return SpinKitRipple(
            size: 25.0,
            color: Theme.of(context).primaryColor,
          );
        },
      );

  static Widget _buildCircleAvatar(CompanyModel company) => Container(
        width: 60.0,
        height: 60.0,
        child: CircleAvatar(
          child: Text(
            company.name[0].toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
      );

  Widget _buildTitle(context, CompanyModel company) => GestureDetector(
        key: Key(company.id),
        child: Card(
          elevation: 5.0,
          child: Column(
            children: <Widget>[
              buildThumnail(context, company),
              SizedBox(height: 5.0),
              _buildCompanyName(company),
              SizedBox(height: 5.0),
              _buildCompanyAddress(company)
            ],
          ),
        ),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailScreen(company))),
      );

  Widget _buildCompanyAddress(CompanyModel company) =>
      Text((company.city == null) ? '' : company.city,
          textAlign: TextAlign.center, overflow: TextOverflow.ellipsis);

  Widget _buildCompanyName(CompanyModel company) => Text(company.name,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ));

  Widget _buildLoading(BuildContext context) => SpinKitRipple(
        color: Theme.of(context).primaryColor,
      );
}
