import 'package:flutter/cupertino.dart';

class Coffe {
  final String name;
  final String image;
  final double price;

  Coffe({this.name, this.image, this.price});

  final names = [
    "Caramel Macchiato",
    " Caramel Cold Drink",
    " Iced Coffe Mocha",
    "Caramelized Pecan Latte",
    "Toffee Nut Latte"
  ];
  final prices = [
    0.12,
    12.5,
    13.0,
    18.0,
    20.0
  ];
}
