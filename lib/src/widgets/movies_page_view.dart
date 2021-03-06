import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';

class MoviesPageView extends StatelessWidget {
  final List<Movie> moviesList;
  final Function getMoreData;

  MoviesPageView({@required this.moviesList, @required this.getMoreData});
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        getMoreData();
      }
    });

    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        controller: _pageController,
        itemCount: moviesList.length,
        pageSnapping: false,
        itemBuilder: (context, position) {
          return _cardMovie(
            context,
            moviesList[position],
            _screenSize,
          );
        },
      ),
    );
  }

  Widget _cardMovie(BuildContext context, Movie movie, Size screeSize) {
    movie.uniqueId = UniqueKey().toString();

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FadeInImage(
                placeholder: AssetImage("lib/assets/img/no-image.jpg"),
                image: NetworkImage(movie.getPosterURL()),
                fit: BoxFit.cover,
                height: screeSize.height * 0.2,
              ),
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
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, "movieDetail", arguments: movie);
      },
    );
  }
}
