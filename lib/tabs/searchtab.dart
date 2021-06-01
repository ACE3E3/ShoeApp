import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shoeapp/constants.dart';
import 'package:e_shoeapp/services/firebaseservices.dart';
import 'package:e_shoeapp/widgets/custominput.dart';
import 'package:e_shoeapp/widgets/productcard.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if(_searchString.isEmpty)
            Center(
              child: Container(
                  child: Text(
                    "Search Results",
                    style: Constants.regularDarkText,
                  ),
              ),
            )
          else
          FutureBuilder<QuerySnapshot>  (
            future: _firebaseServices.productRef.orderBy("search_string")
                .startAt([_searchString])
                .endAt(["$_searchString\uf8ff"])
                .get(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Scaffold(
                  body: Center(
                      child: Text("Error : ${snapshot.error}")
                  ),
                );
              }

              if(snapshot.connectionState == ConnectionState.done){
                // Display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 120.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "\$${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInput(
              hintText: "Search here...",
              onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
              },
            ),
          ),
        ],
      ),
    );
  }
}
