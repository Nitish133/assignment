import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var jsondata = {};
  bool datafound = false;
  var url = "https://dummyjson.com/products";
  //add on feature for category
  //var categoryurl = "https://dummyjson.com/products/category-list";
  

  
  getdata() async {
    var data = await Dio().get(url);
    jsondata = data.data;
    

    setState(() {
      datafound = true;
    });
  }

  @override
  
  void initState() {
    super.initState();
    getdata();
  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: "Home Page".text.white.bold.makeCentered(),
          backgroundColor: Vx.blue500,
          
        ),
      
        body: Column(
          children: [
            Expanded(
              child: datafound
                  ? ListView.builder(
                      itemCount: jsondata['products'].length,
                      itemBuilder: (context, index) {
                        final product = jsondata['products'][index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          elevation: 4.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/product_details",
                                arguments: product['id'],
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      product["thumbnail"],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product["title"],
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "\$${product['price'].toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          "Rating: ${product['rating'].toStringAsFixed(1)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
