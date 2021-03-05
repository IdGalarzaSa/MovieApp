import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';

class MoviesPageView extends StatelessWidget {
  final List<Movie> moviesList;

  MoviesPageView({@required this.moviesList});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _cardsMovies(context, _screenSize),
        pageSnapping: false,
      ),
    );
  }

  List<Widget> _cardsMovies(BuildContext context, Size screeSize) {
    return moviesList.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FadeInImage(
                placeholder: AssetImage("lib/assets/img/no-image.jpg"),
                image: NetworkImage(movie.getPosterURL()),
                fit: BoxFit.cover,
                height: screeSize.height * 0.2,
              ),
            ),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
