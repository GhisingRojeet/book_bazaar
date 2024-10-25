import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              i,
              fit: BoxFit.cover,
              height: 300,
            ),
          );
        },
      ).toList(),
      options:
          CarouselOptions(autoPlay: true, viewportFraction: 2, height: 225),
    );
  }
}
