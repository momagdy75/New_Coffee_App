import 'package:flutter/material.dart';

import 'Product.dart';

List<Product> products = [
  Product(
      name: "Cinnamon &\nCocoa",
      price: "9",
      image: "assets/images/product1.jpg",
      rate: "4.5",
      count: 1,
      type: "Coffee",
  description:"If you have ever tasted cinnamon straight out of the jar, it has a bitter taste. However, when you mix it in your food and drink, the flavour profile changes completely."
  ),
  Product(
      name: "Drizzled with\nCaramel",
      price: "17",
      image: "assets/images/product2.jpg",
      count: 1,
      rate: "4.7",
        type: "Coffee",
  description: "Homemade iced caramel coffee is equal parts delicious, refreshing and easy! It’s a cold glass of cold coffee and milk, drizzled with caramel and topped with the option of whipped cream"
  ),
  Product(
      name: "Bursting\nBlueberry",
      price: "29",
      image: "assets/images/product3.jpg",
      count: 1,
      type: "Coffee",
      rate: "4.9",
    description: "Blueberry is a delicious and refreshing drink that is made with fresh blueberries, milk and sugar. It’s a great way to start your day or to add a little extra sweetness to your afternoon Coffee."
  ),
  Product(
      name: "Dalgona\nWhipped",
      price: "23",
      image: "assets/images/product4.jpg",
      count: 1,
      type: "Coffee",
      rate: "4.1",
    description: "Dalgona is a delicious and refreshing drink, milk and sugar. It’s a great way to start your day or to add a little extra sweetness to your afternoon Coffee."
  ),
  Product(
      name: "hazelnut \nCoffee",
      price: "10",
      type: "Coffee",
      count: 1,
      image: "assets/images/product5.jpg",
      description: "Hazelnut coffee is a delicious and refreshing drink that is made with hazelnut milk and sugar. It’s a great way to start your day or to add a little extra sweetness to your afternoon Coffee.",
      rate: "4.3",
      ),
  Product(
      name: "Milky\nCoffee",
      price: "12",
      type: "Coffee",
      image: "assets/images/product6.jpg",
      count: 1,
      rate: "4.4",
  description: "Milky Coffee is a delicious and refreshing drink. It’s a great way to start your day or to add a little extra sweetness to your afternoon Coffee."
  ),
];
List<String> CoffeeNames = [
  "Cappuccino",
  "Latte",
  "Americano",
  "Espresso",
  "Flat White",
];
List<Product> CartProducts=[];
List<String> CartProductNames=[];