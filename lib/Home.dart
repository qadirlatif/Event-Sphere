import 'package:eventsphere/EventDetail.dart';
import 'package:eventsphere/SocietyDetail.dart';
import 'package:eventsphere/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Society> societies = [];
  List<Event> events = [];
  bool isload = true;
  Future<void> fetchDataofSocieties() async {
    final response = await http
        .get(Uri.parse('http://EventSphere.somee.com/Society/TopSocieties'));
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      for (int i = 0; i < values.length; i++) {
        Society society = Society();
        society.ID = values[i]["ID"] ?? "";
        society.SocietyName = values[i]["SocietyName"] ?? "";
        society.ImageURL = values[i]["SocietyIcon"] ?? "";
        societies.add(society);
      }
      // userid = values["userid"];

      setState(() {
        isload = false;
      });
    } else {}
  }

  Future<void> fetchDataofEvents() async {
    final response = await http
        .get(Uri.parse('http://EventSphere.somee.com/Society/TopEvents'));
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      for (int i = 0; i < values.length; i++) {
        Event event = Event();
        event.ID = values[i]["ID"] ?? 0;
        event.EventName = values[i]["EventName"] ?? "";
        String rawDate = values[i]["EventDateandTime"] ?? "";
        try {
          // Extract the number from the /Date(1721840400000)/ format
          final timestamp =
              int.parse(rawDate.replaceAll(RegExp(r'[^0-9]'), ''));
          // Convert the timestamp to a DateTime object in UTC
          DateTime utcDate =
              DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
          // Convert the UTC time to local time
          event.EventDateandTime = utcDate.toLocal();
        } catch (e) {
          print("Error parsing date: $e");
        }

        event.EventVenue = values[i]["EventVenue"] ?? "";
        event.EventCity = values[i]["EventCity"] ?? "";
        event.SocietyID = values[i]["SocietyID"] ?? 0;
        event.EventIcon = values[i]["EventIcon"] ?? "";

        events.add(event);
      }
      // userid = values["userid"];

      setState(() {
        isload = false;
      });
    } else {}
  }

  @override
  void initState() {
    fetchDataofEvents();
    fetchDataofSocieties();
    // TODO: implement initState
    super.initState();
  }

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
                isload
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < events.length; i++)
                              GestureDetector(
                                child: card(
                                    context,
                                    events[i].EventIcon,
                                    events[i].EventName,
                                    "",
                                    false,
                                    events[i].EventDateandTime.toString()),
                                onTap: () {
                                  Navigator.pushNamed(context, '/EventDetail', arguments: events[i]);
                                },
                              )
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
                      for (int i = 0; i < societies.length; i++)
                        GestureDetector(
                          child: card(context, societies[i].ImageURL, "",
                              societies[i].SocietyName, true, ""),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SocietyDetail(
                                          id: societies[i].ID,
                                        )));
                          },
                        )
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

  Widget card(var context, String ImageURL, String eventname,
      String societyname, bool isSociety, String time) {
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
              child: isSociety
                  ? Image.network(
                      "http://eventsphere.somee.com/SocietyDetailsImages/${ImageURL}",
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      "http://eventsphere.somee.com/EventIcon/${ImageURL}",
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                child: Text(eventname)),
            isSociety
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Text(
                      societyname,
                      style: const TextStyle(fontSize: 12),
                    ))
                : Padding(padding: EdgeInsets.all(0)),
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
                          time.substring(0, 20),
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
