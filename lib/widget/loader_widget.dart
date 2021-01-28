import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

showLoaderWidget() {
  return Center(
      child: Image.asset(
    "assets/applogoloadergif.gif",
    height: 60.0,
    width: 60.0,
  ));
}

Widget showShimmerDesign(context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    child: Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.white,
      highlightColor: Colors.grey[300],
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (_, index) {
          return Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
                Container(
                  height: 3,
                ),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
                Container(
                  height: 3,
                ),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
