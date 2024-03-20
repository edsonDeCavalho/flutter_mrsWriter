import 'package:flutter/material.dart';


class EmptyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('z'
              'Empty page',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Image.asset('images/logo/ic_launcher_round.png'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}