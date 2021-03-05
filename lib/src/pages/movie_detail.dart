import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${movie.title}',
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(),
    );
  }
}
