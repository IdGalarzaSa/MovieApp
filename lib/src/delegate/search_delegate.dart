import 'package:flutter/material.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';
import 'package:movies_app/src/connection/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones de nuestro Appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono de la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    // Las sugerencias que obtenemos
    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final moviesResponse = snapshot.data;

          return ListView(
            children: moviesResponse.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  height: 50.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage("lib/assets/img/loading.gif"),
                  image: NetworkImage(movie.getPosterURL()),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // close(context, null);
                  movie.uniqueId = "";
                  Navigator.pushNamed(context, "movieDetail", arguments: movie);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
