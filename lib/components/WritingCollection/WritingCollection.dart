import 'package:flutter/material.dart';

class WritingCollection extends StatelessWidget {
  final String imageUrl;
  final List<String> strings;

  WritingCollection({required this.imageUrl, required this.strings});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // Image on the left
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Strings in a column next to the image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Title"),Text("Hello"),Text("Last update : ")]
          ),
        ],
      ),
    );
  }
}