import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';
import 'package:movies_app/src/connection/providers/movies_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
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
          children: [
            _swiper(),
          ],
        ),
      ),
    );
  }

  Widget _swiper() {
    final moviesProvider = new MoviesProvider();
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
}
