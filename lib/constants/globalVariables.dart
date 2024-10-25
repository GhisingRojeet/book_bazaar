import 'package:flutter/material.dart';

String uri = 'http://192.168.100.74:3000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 92, 29, 201),
      Color.fromARGB(255, 129, 10, 209),
    ],
    stops: [0.5, 1.0],
  );

  //static images
  static const secondaryColor = Color.fromRGBO(146, 28, 235, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 53, 25, 133);
  static const unselectedNavBarColor = Colors.black87;
  static const List<String> carouselImages = [
    'https://w7.pngwing.com/pngs/740/46/png-transparent-digital-library-community-glass-rectangle-bookcase-thumbnail.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC3tl-jPUDir4n-0DiltC7mXMs2rdjTgXheA&s',
    'https://assets-cdn.kathmandupost.com/uploads/source/news/2024/third-party/bookcover-1712370114.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsuJR3YA2aWxbRELWDgcutcz-X1TisVkQpJg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShrbRnIDIH2q7c84PvTXFjvD45N30mvuR-gg&s'
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Literature',
      'image': 'assets/images/book.jpg',
    },
    {
      'title': 'Romance',
      'image': 'assets/images/book.jpg',
    },
    {
      'title': 'Science',
      'image': 'assets/images/book.jpg',
    },
    {
      'title': 'Horror',
      'image': 'assets/images/book.jpg',
    },
    {
      'title': 'History',
      'image': 'assets/images/book.jpg',
    },
    {
      'title': 'Discipline',
      'image': 'assets/images/book.jpg',
    },
    {
      'title': 'Biography',
      'image': 'assets/images/book.jpg',
    },
  ];
}
