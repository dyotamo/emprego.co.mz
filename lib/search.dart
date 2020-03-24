import 'package:flutter/material.dart';
import 'package:prov/client.dart';
import 'package:prov/home.dart';
import 'package:prov/model.dart';

class CompanySearch extends SearchDelegate {
  CompanySearch()
      : super(
            searchFieldLabel: 'Pesquise aqui...',
            textInputAction: TextInputAction.none);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
                  return HomeScreen.buildTitle(company);
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
}
