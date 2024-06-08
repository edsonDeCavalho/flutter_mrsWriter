import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenue !',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Image.asset('images/logo/ic_launcher_round.png'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton
                Navigator.pushNamed(context, '/BottomNavigationBarScreen');
                print("Let'go bottom was pressed");
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Button border radius
                ),
                elevation: 3, // Button elevation

              ),
              child: Text("Let's go"), // Button text
            ),
          ],
        ),
      ),
    );
  }
}