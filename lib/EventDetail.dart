import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  const EventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.65,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    ClipRRect(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Image.network(
                        "https://cdn.britannica.com/85/128585-050-5A1BDD02/Karachi-Pakistan.jpg",
                        fit: BoxFit.cover,
                      ),
                    )),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.black.withOpacity(0.7),
                              ],
                              stops: const [
                                0.0,
                                1.0
                              ])),
                    ),
                    SafeArea(
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.location_pin,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Event Name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08),
                                      ),
                                      const Text(
                                        "Took Place on 5/12/2024 5:00 PM",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      ),
                                      const Text(
                                        "Karachi, Pakistan",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )))
                  ],
                )),
            const Text(
              "How was this Event?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              "Leave your review so that we can find \nyour opinion",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
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
                "VISIT NETWORKING CHAT",
                style: TextStyle(color: Colors.white),
              )),
            ),
            onTap: (){
              Navigator.pushNamed(context, "/Reviews");
            },)
          ],
        ),
      ),
    );
  }
}
