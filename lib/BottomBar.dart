import 'package:eventsphere/Aboutus.dart';
import 'package:eventsphere/ExploreCommunities.dart';
import 'package:eventsphere/Home.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:index == 0? const Home() : index == 1 ? const ExploreCommunities() : const Aboutus(),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){
              setState(() {
                index = 0;
              });
            }, icon: index == 0? const Icon(Icons.home,size: 30, color: Color.fromRGBO(194, 155, 110, 1),) :const  Icon(Icons.home,size: 30, color: Colors.grey,) ),
            IconButton(onPressed: (){
              setState(() {
                index = 1;
              });
            }, icon: index == 1?const Icon(Icons.explore,size: 30, color: Color.fromRGBO(194, 155, 110, 1),) :const Icon(Icons.explore,size: 30, color: Colors.grey,)),
           
            // IconButton(onPressed: (){
            //   setState(() {
            //     index = 2;
            //   });
            // }, icon: index == 2?const  Icon(Icons.info,size: 30, color: Color.fromRGBO(194, 155, 110, 1),) :const  Icon(Icons.info,size: 30, color: Colors.grey,))
          ],
        )
          
        
      ),
    );;
  }
}