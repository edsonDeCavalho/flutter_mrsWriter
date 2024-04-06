import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/data/Note.dart';
import '../../style/colors.dart';
import '../accueil/accueilPage.dart';
import '../createWritePage/createWritePage.dart';
import '../emptyPage/emptypage.dart';
import '../listOfWritings/listOfWritings.dart';
import '../welcome/WelcomePage.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);
  @override
  State createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State {
  int _selectedIndex = 0;
  List<Widget> pageList = [
    AccueilPage(),
    EmptyPage(),
    ListOfWritings(),
    EmptyPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pageList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: AppColor.backgroundWhite,
          border: Border(
            top: BorderSide(width: 0.5, color: AppColor.stroke),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColor.backgroundWhite,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), // Add icon for Accueil
              label: "Accueil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.science), // Add icon for WritePad
              label: "WritePad",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore), // Add icon for Account
              label: "Writings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), // Add icon for Account (active)
              label: "Account",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColor.primary5,
          unselectedItemColor: AppColor.black,
          iconSize: 24,
          onTap: _onItemTapped,
          elevation: 0,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedLabelStyle: const TextStyle(letterSpacing: 1),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 55,
        height: 55,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/createWriting');
            },
            backgroundColor: AppColor.primary5,
            elevation: 3,
            child: const Icon(
              Icons.create,
              size: 35,
              color: Colors.white, // Customize the color if needed
            ),
          ),
        ),
      ),
    );
  }
}
