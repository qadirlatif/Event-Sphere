import 'package:flutter/material.dart';

class ExploreCommunities extends StatefulWidget {
  const ExploreCommunities({super.key});

  @override
  State<ExploreCommunities> createState() => _ExploreCommunitiesState();
}

class _ExploreCommunitiesState extends State<ExploreCommunities> {
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
              padding:  EdgeInsets.all(10),
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
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Cards(context),
              Cards(context),
              Cards(context),
              Cards(context),
              Cards(context),
              Cards(context),
            ]),
          )),
        )
      ],
    );
  }

  Widget Cards(var context) {
    return Padding(
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
                  "https://cdn.britannica.com/85/128585-050-5A1BDD02/Karachi-Pakistan.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: const Column(
                  children: [
                    Text(
                      "Gaming & Robotics Society",
                      style: TextStyle(fontSize: 17),
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
        ));
  }
}
