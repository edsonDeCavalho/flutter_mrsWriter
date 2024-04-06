import 'package:flutter/material.dart';
import '../../components/ListOfWritingCollection/ListOfWritingCollection.dart';

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('Bonjour', style: TextStyle(fontSize: 18)),
            SizedBox(width: 8),
            Text('Edson !', style: TextStyle(fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Action to perform when the notification icon is pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Action to perform when the history icon is pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Action to perform when the settings icon is pressed
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Your Text Here', // Add your desired text here
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: MiniCollectionList(),
          ),
        ],
      ),
    );
  }
}
