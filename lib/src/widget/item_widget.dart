import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/src/widget/circle_image.dart';



class ItemWidget extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  final String title;
  final String status;
  final int price;

  ItemWidget({
    this.imageUrl,
    this.title,
    this.status,
    this.price,
    this.imageSize = 70.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          CircleImage(size: imageSize, imageUrl: imageUrl ?? ""),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),

              ],
            ),
          ),
          Text(price.toString() ?? "",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                 ))
        ],
      ),
    );
  }
}
