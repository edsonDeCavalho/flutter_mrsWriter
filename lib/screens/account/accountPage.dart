// lib/account_page.dart
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Image
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/logo/ic_launcher_round.png'), // Replace with NetworkImage for network image
            ),
            SizedBox(height: 16),
            // User Name
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // User Email
            Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            // Additional Details
            Card(
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text('+1 234 567 890'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('123 Main St, Springfield, USA'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.work),
                title: Text('Software Engineer at XYZ Corp.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
