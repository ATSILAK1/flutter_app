import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;
  double buttonScales = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      
       BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(22,22,22,1),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        
        

        items:  [
          
          BottomNavigationBarItem(
                
            icon:  Image.asset("assets/img/Home1.png" ,scale: pageIdx == 0 ? buttonScales:1,),
            label: '',

          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/img/Search.png", scale: pageIdx == 1 ? buttonScales:1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/img/Add.png",scale: pageIdx == 2 ? buttonScales:1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/img/Message.png",scale: pageIdx == 3 ? buttonScales:1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/img/Profile.png",scale: pageIdx == 4 ? buttonScales:1),
            label: '',
          ),
        ],
      ),
      body: pages[pageIdx],
    );
  }
}
