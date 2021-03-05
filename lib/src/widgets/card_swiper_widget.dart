import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';

class CardSwiperWidget extends StatelessWidget {
  // const CardSwiperWidget({Key key}) : super(key: key);

  final List<Movie> items;

  CardSwiperWidget({@required this.items});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: screenSize.width * 0.6,
        itemHeight: screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(35.0),
              child: FadeInImage(
                image: NetworkImage(items[index].getPosterURL()),
                placeholder: AssetImage("lib/assets/img/no-image.jpg"),
                fit: BoxFit.fill,
              ));
        },
        itemCount: items.length,
      ),
    );
  }
}
