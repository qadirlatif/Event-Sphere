import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromRGBO(56, 89, 108, 0.7),
                  Color.fromRGBO(56, 89, 108, 1.0)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Discover Communities",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.08),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                  const Text(
                    "And their Upcoming Events",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )
                ],
              ),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.72,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Latest Events",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: card(context, "first event", "robotics society",
                            false, "10/12/2024 5:00 PM"),
                        onTap: () {
                          Navigator.pushNamed(context, "/EventDetail");
                        },
                      ),
                      card(context, "second event", "gaming society", false,
                          "10/5/2024 5:00 PM"),
                      card(context, "thhird event", "media society", false,
                          "10/2/2024 5:00 PM"),
                      card(context, "fourth event", "cricket society", false,
                          "10/7/2024 5:00 PM"),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                const Text(
                  "Top Societies",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      card(context, "first event", "robotics society", true,
                          "10/12/2024 5:00 PM"),
                      card(context, "second event", "gaming society", true,
                          "10/5/2024 5:00 PM"),
                      card(context, "thhird event", "media society", true,
                          "10/2/2024 5:00 PM"),
                      card(context, "fourth event", "cricket society", false,
                          "10/7/2024 5:00 PM"),
                    ],
                  ),
                ),
              ],
            ),
          )),
        )
      ],
    );
  }

  Widget card(var context, String eventname, String societyname, bool isSociety,
      String time) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 1,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              child: Image.network(
                "https://cdn.britannica.com/85/128585-050-5A1BDD02/Karachi-Pakistan.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                child: Text(eventname)),
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                child: Text(
                  societyname,
                  style: const TextStyle(fontSize: 12),
                )),
            isSociety == false
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          size: 20,
                        ),
                        Text(
                          time,
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  )
                : const Text("")
          ],
        ),
      ),
    );
  }
}
