import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:empresas.co.mz/api/client.dart';
import 'package:empresas.co.mz/widgets/home.dart';
import 'package:empresas.co.mz/model/model.dart';

class CompanySearch extends SearchDelegate<CompanyModel> {
  CompanySearch() : super(searchFieldLabel: 'Pesquise aqui...');

  @override
  List<Widget> buildActions(BuildContext context) => [];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty)
      return Center(
        child: Text('Ex: Escolas, Farmácias, Hospitais...'),
      );

    return FutureBuilder<List<CompanyModel>>(
        future: searchCompanies(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.clear, size: 75.0),
                    ),
                    Text(
                      'Sem resultados',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var company = snapshot.data[index];
                  return ListTile(
                    key: Key(company.id),
                    leading: HomeScreen.buildThumnail(context, company),
                    title: Text(company.name),
                    subtitle: Text(company.addressOrCity),
                    onTap: () => close(context, company),
                  );
                });
          } else if (snapshot.hasError) {
            return HomeScreen.buildErrorView(snapshot.error);
          }

          return Center(
            child: SpinKitRipple(color: Theme.of(context).primaryColor),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) => Center(
        child: Text('Ex: Escolas, Farmácias, Hospitais...'),
      );
}
