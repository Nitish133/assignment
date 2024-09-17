import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var jsondata = {};
  bool isLoading = true; // Add a loading state

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pro_del(); // Call the API after the context is available
  }

  pro_del() async {
    final productId = ModalRoute.of(context)?.settings.arguments;
    if (productId != null) {
      var url = "https://dummyjson.com/products/$productId";
      var data = await Dio().get(url);
      setState(() {
        jsondata = data.data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: isLoading
          ? Center(
              child:
                  const CircularProgressIndicator()) 
          : jsondata.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(jsondata['images'][0]),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          jsondata['title'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0), // Shadow position
                                blurRadius: 3.0, // Shadow blur radius
                                color: Colors.black.withOpacity(
                                    0.5), // Shadow color with opacity
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\$" + jsondata['price'].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: VxRating(
                          onRatingUpdate: (value) {},
                          count: 5,
                          value: jsondata['rating'],
                          selectionColor: Colors.teal,
                          size: 30,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(3),
                        child: Text(jsondata['description']),
                      ),
                     const SizedBox(
                        height: 20,
                      ),
                      VxSwiper.builder(
                        itemCount: jsondata['reviews'].length,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        height: 160,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                          BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                          
                              SizedBox(height: 8),
                                Text(
                                  jsondata['reviews'][index]['comment'] ??
                                      'No comment available',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Rating: ${jsondata['reviews'][index]['rating'].toStringAsFixed(1)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Reviewer: ${jsondata['reviews'][index]['reviewerName'] ?? 'Anonymous'}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const Text(
                  "No product details available"), 
    );
  }
}
