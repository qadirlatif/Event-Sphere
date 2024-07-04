import 'package:eventsphere/EventDetail.dart';
import 'package:eventsphere/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExploreEvents extends StatefulWidget {
  const ExploreEvents({super.key});
  @override
  State<ExploreEvents> createState() => _ExploreEventsState();
}

class _ExploreEventsState extends State<ExploreEvents> {
  int? societyID;
  List<Event> events = [];
  bool isload = true;
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://EventSphere.somee.com/Society/GetEventsofSociety?ID=${societyID}'));
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
    
    // TODO: implement initState
    super.initState();
    societyID = ModalRoute.of(context)!.settings.arguments as int?;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
         

    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.1,
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
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Events",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.82,
          child: isload
              ? const Center(child: CircularProgressIndicator())
              : events.length > 0
                  ? SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < events.length; i++)
                              Cards(context, events[i]),
                          ]),
                    ))
                  : Center(
                      child: Text("No Communities to be displayed"),
                    ),
        )
      ],
    );
  }

  Widget Cards(var context, Event event) {
    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    "http://eventsphere.somee.com/SocietyDetailsImages/${event.EventIcon}",
                    fit: BoxFit.fill,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Text(
                        event.EventName,
                        style: const TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.arrow_forward_ios)],
                )
              ],
            ),
          )),
      onTap: () {
        // MaterialPageRoute(
        //     builder: (context) => EventDetail(
        //           event: event,
        //         ));
      },
    );
  }
}
