import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Choice extends StatelessWidget {
  const Choice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      ' Connecting Communities, Creating Memories ', textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(6, 72, 116, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 50000000000000,
                  pause: const Duration(milliseconds: 2000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                )),
                GestureDetector(child:
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(224, 194, 157, 1),
                    Color.fromRGBO(194, 155, 110, 1)
                  ],
                ),
              ),
              child: const Center(
                  child: Text(
                "GET STARTED AS GUEST",
                style: TextStyle(color: Colors.white),
              )),
            ),
            onTap: (){
              Navigator.pushNamed(context, "/BottomBar");
            },),
            const Padding(padding: EdgeInsets.all(10)),
            GestureDetector(child:
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(224, 194, 157, 1),
                    Color.fromRGBO(194, 155, 110, 1)
                  ],
                ),
              ),
              child: const Center(
                  child: Text(
                "GET STARTED AS ADMIN",
                style: TextStyle(color: Colors.white),
              )),
            ),
            onTap: (){
              Navigator.pushNamed(context, "/login");
            },)
          ],
        ),
      ),
    ));
  }
}
