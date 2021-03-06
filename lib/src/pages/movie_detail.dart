import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_app/src/connection/models/cast_model.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';
import 'package:movies_app/src/connection/providers/movies_provider.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(context, movie, size),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20),
              _movieInformationRow(context, movie, size),
              SizedBox(height: 20),
              _movieDescriptionInformation(context, movie, size),
              SizedBox(height: 20),
              _casting(context, movie, size),
            ]),
          ),
          // _movieInformationRow(context, movie, size),
        ],
      ),
    );
  }

  Widget _sliverAppBar(BuildContext context, Movie movie, Size size) {
    return SliverAppBar(
      elevation: 5.0,
      backgroundColor: Colors.blueGrey,
      expandedHeight: size.height * 0.20,
      pinned: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
        ),
        background: FadeInImage(
          placeholder: AssetImage("lib/assets/img/loading.gif"),
          image: NetworkImage(movie.getBackgroundImage()),
          fadeInDuration: Duration(milliseconds: 250),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _movieInformationRow(BuildContext context, Movie movie, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.20,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: FadeInImage(
                placeholder: AssetImage("lib/assets/img/loading.gif"),
                image: NetworkImage(movie.getPosterURL())),
          ),
          SizedBox(width: 30),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                movie.title,
                maxLines: 3,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text(
                movie.originalTitle,
                maxLines: 3,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rate, color: Colors.yellow),
                  SizedBox(width: 20),
                  Text(movie.voteAverage.toString())
                ],
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget _movieDescriptionInformation(
      BuildContext context, Movie movie, Size size) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        movie.overview,
        style: TextStyle(),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _casting(BuildContext context, Movie movie, Size size) {
    final movieProvider = MoviesProvider();
    return Center(
      child: FutureBuilder(
        future: movieProvider.getCast(movie),
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
          if (snapshot.hasData) {
            return _castingPageView(snapshot.data, size);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _castingPageView(List<Cast> data, Size size) {
    return Container(
      height: size.height * 0.30,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        pageSnapping: false,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int position) {
          return Column(
            children: [
              _castCard(data[position], size),
              SizedBox(
                height: 10,
              ),
              Text(
                data[position].name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _castCard(Cast cast, Size size) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: FadeInImage(
          height: size.height * 0.20,
          fit: BoxFit.cover,
          placeholder: AssetImage('lib/assets/img/loading.gif'),
          image: NetworkImage(cast.getPhotoURL()),
        ),
      ),
    );
  }
}
