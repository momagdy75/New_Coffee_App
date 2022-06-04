//create product class with string name and price and image and rate
import 'package:flutter/material.dart';

class Product {
  String name;
  String price;
  String image;
  String type;
  String rate;
  String description;
  int count;

  Product(
      {required this.name,
      required this.price,
      required this.image,
      required this.rate,
      required this.description,
      required this.count,
        required this.type
      });
}
