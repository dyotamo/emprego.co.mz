import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:prov/client.dart';
import 'package:prov/model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagewiseListView(
      pageSize: 10,
      pageFuture: (page) => fetchCompanies(page),
      itemBuilder: (context, company, _) => _buildTitle(company),
    );
  }

  Widget _buildLeading(CompanyModel company) {
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

  Widget _buildTitle(CompanyModel company) {
    return ListTile(
      leading: _buildLeading(company),
      title: Text(company.name),
      trailing: _buildTrailing(company),
    );
  }

  Icon _buildTrailing(CompanyModel company) {
    return Icon(
      Icons.verified_user,
      color: (company.image == null) ? Colors.black : Colors.blue,
      size: 15.0,
    );
  }
}
