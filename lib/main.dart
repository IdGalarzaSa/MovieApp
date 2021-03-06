import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_app/src/pages/home_page.dart';
import 'package:movies_app/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (BuildContext context) => HomePage(),
        'movieDetail': (BuildContext context) => MovieDetailPage(),
      },
    );
  }
}
