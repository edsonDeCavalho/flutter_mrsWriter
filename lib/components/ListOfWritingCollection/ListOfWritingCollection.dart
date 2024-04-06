import 'package:flutter/cupertino.dart';

import '../WritingCollection/WritingCollection.dart';

class MiniCollectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample list of MiniCollection data
    List<Map<String, dynamic>> miniCollectionData = [
      {
        'imageUrl': 'https://plus.unsplash.com/premium_photo-1674677530889-72b7cf7f1450?q=80&w=3453&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 1', 'Description 1']
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1711639105861-f55ef78adc51?q=80&w=2309&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 2', 'Description 2']
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1711639105861-f55ef78adc51?q=80&w=2309&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 2', 'Description 2']
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1711639105861-f55ef78adc51?q=80&w=2309&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 2', 'Description 2']
      }, {
        'imageUrl': 'https://images.unsplash.com/photo-1711639105861-f55ef78adc51?q=80&w=2309&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 2', 'Description 2']
      }, {
        'imageUrl': 'https://plus.unsplash.com/premium_photo-1674677530889-72b7cf7f1450?q=80&w=3453&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 1', 'Description 1']
      },
      {
        'imageUrl': 'https://plus.unsplash.com/premium_photo-1674677530889-72b7cf7f1450?q=80&w=3453&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 1', 'Description 1']
      },
      {
        'imageUrl': 'https://plus.unsplash.com/premium_photo-1674677530889-72b7cf7f1450?q=80&w=3453&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 1', 'Description 1']
      },
      {
        'imageUrl': 'https://plus.unsplash.com/premium_photo-1674677530889-72b7cf7f1450?q=80&w=3453&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'strings': ['Item 1', 'Description 1']
      },
      // Add more data as needed...
    ];

    return ListView.builder(
      itemCount: miniCollectionData.length,
      itemBuilder: (BuildContext context, int index) {
        final data = miniCollectionData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 11.0),
          child: WritingCollection(
            imageUrl: data['imageUrl'],
            strings: List<String>.from(data['strings']),
          ),
        );
      },
    );
  }
}