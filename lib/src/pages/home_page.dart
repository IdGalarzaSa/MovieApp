import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';
import 'package:movies_app/src/connection/providers/movies_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movies_page_view.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key key}) : super(key: key);
  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Peliculas en cines"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_swiper(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiper() {
    return FutureBuilder<List<Movie>>(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidget(
            items: snapshot.data,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            "Populares",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder(
          future: moviesProvider.getPopularMovies(),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return MoviesPageView(
                moviesList: snapshot.data,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
      ],
    );
  }
}
