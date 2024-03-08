import 'package:flutter/material.dart';

import '../../style/colors.dart';
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
    EmptyPage(),
    ListOfWritings()
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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                //child: Image.asset('images/bottomBarNav/Home.png'),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                //child: Image.asset('images/bottomBarNav/HomeActive.png'),
              ),
              label: "Accueil",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                //child: Image.asset('images/bottomBarNav/Home.png'),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                //child: Image.asset('images/bottomBarNav/HomeActive.png'),
              ),
              label: "WritePad",
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
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/createWriting');
            },
            backgroundColor: AppColor.primary5,
            elevation: 1,
            child: Icon(
              Icons.insert_drive_file,
              size: 35,
              color: Colors.white, // Customize the color if needed
            ),
          ),
        ),
      ),
    );
  }
}
