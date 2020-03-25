import 'package:flutter/material.dart';
import 'package:prov/client.dart';
import 'package:prov/home.dart';
import 'package:prov/model.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.clear, size: 25.0),
                    Text('Sem resultados'),
                  ],
                ),
              );

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var company = snapshot.data[index];
                  return ListTile(
                    key: Key(company.id),
                    leading: HomeScreen.buildLeading(company),
                    title: Text(company.name),
                    subtitle: Text(company.addressOrCity),
                    onTap: () => close(context, company),
                  );
                });
          } else if (snapshot.hasError) {
            return HomeScreen.buildErrorView(snapshot.error);
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 25.0,
                      height: 25.0,
                      child: CircularProgressIndicator()),
                ),
                Text('Pesquisando...')
              ],
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) => Center(
        child: Text('Ex: Escolas, Farmácias, Hospitais...'),
      );
}
