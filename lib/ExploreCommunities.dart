import 'package:eventsphere/SocietyDetail.dart';
import 'package:eventsphere/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExploreCommunities extends StatefulWidget {
  const ExploreCommunities({super.key});

  @override
  State<ExploreCommunities> createState() => _ExploreCommunitiesState();
}

class _ExploreCommunitiesState extends State<ExploreCommunities> {
  List<Society> societies = [];
  bool isload = true;
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://EventSphere.somee.com/Society/GetAllSociety'));
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      for (int i = 0; i < values.length; i++) {
        Society society = Society();
        society.ID = values[i]["ID"] ?? 0;
        society.SocietyName = values[i]["SocietyName"] ?? "";
        society.ImageURL = values[i]["SocietyIcon"] ?? "";
        // Order order = Order();
        // order.ID = values[i]["ID"] ?? 0;
        // order.Name = values[i]["CustomerName"] ?? "";
        // order.Number = values[i]["Number"] ?? "";
        // order.CityName = values[i]["CityName"] ?? "";
        // order.Address = values[i]["Address"] ?? "";
        // order.Product = values[i]["Product"] ?? "";
        // order.Amount = values[i]["Amount"] ?? "";
        // order.Status = values[i]["Status"] ?? "";
        // order.TrackingID = values[i]["TrackingID"] ?? "";

        // orders.add(order);
        societies.add(society);
      }
      // userid = values["userid"];

      setState(() {
        isload = false;
      });
    } else {}
  }

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
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
                    "Communities",
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
              : societies.length > 0
                  ? SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < societies.length; i++)
                              Cards(context, societies[i]),
                          ]),
                    ))
                  : Center(
                      child: Text("No Communities to be displayed"),
                    ),
        )
      ],
    );
  }

  Widget Cards(var context, Society society) {
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
                    "http://eventsphere.somee.com/SocietyDetailsImages/${society.ImageURL}",
                    fit: BoxFit.fill,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Text(
                        society.SocietyName,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SocietyDetail(
                      id: society.ID,
                    )));
      },
    );
  }
}
