import 'package:assignment/pages/Product_details.dart';
import 'package:assignment/pages/product.dart';
import 'package:flutter/material.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
      "/":(context)=> const Product(),
      "/product_details":(context)=>const ProductDetails()
      },
    );
  }
}