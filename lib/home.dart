import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:prov/client.dart';
import 'package:prov/model.dart';
import 'package:prov/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('empresas.co.mz'),
          actions: _buildActions(context),
        ),
        body: PagewiseListView(
          showRetry: false,
          padding: EdgeInsets.all(8.0),
          pageSize: 20,
          pageFuture: (page) => fetchCompanies(page),
          itemBuilder: (_, company, __) => buildTitle(company),
          loadingBuilder: (_) => _buildLoadingData(),
          errorBuilder: (_, error) => buildErrorView(error.toString()),
        ));
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () =>
            showSearch(context: context, delegate: CompanySearch()),
      )
    ];
  }

  Widget _buildLoadingData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Carregando empresas',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(width: 10.0),
          Container(
              width: 15.0, height: 15.0, child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  static Widget buildErrorView(Object error) {
    return Padding(
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
  }

  static Widget _buildLeading(CompanyModel company) {
    return (company.image == null)
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
  }

  static Widget buildTitle(CompanyModel company) {
    return ListTile(
      leading: _buildLeading(company),
      title: Text(company.name),
      subtitle: Text(company.addressOrCity),
      trailing: _buildTrailing(company),
    );
  }

  static Icon _buildTrailing(CompanyModel company) {
    return Icon(
      Icons.verified_user,
      color: (company.image == null) ? Colors.black : Colors.blue,
      size: 15.0,
    );
  }
}
