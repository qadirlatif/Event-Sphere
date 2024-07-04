import 'package:eventsphere/EventList.dart';
import 'package:eventsphere/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SocietyDetail extends StatefulWidget {
  SocietyDetail({super.key, required this.id});
int id;
  @override
  State<SocietyDetail> createState() => _SocietyDetailState();
}

class _SocietyDetailState extends State<SocietyDetail> {
  SocietyandDetails societyandDetails = SocietyandDetails();
  bool isload = true;
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://EventSphere.somee.com/Society/SocietyandDetails?ID=${widget.id}'));
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      // for (int i = 0; i < values.length; i++) {
      societyandDetails.society = Society();
      societyandDetails.detail = SocietyDetails();
        Society society = Society();
        society.ID = values["society"]["ID"] ?? 0;
        society.SocietyName = values["society"]["SocietyName"] ?? "";
        society.ImageURL = values["society"]["SocietyIcon"] ?? "";
        SocietyDetails detail = SocietyDetails();
        detail.SocietyID = values["Detail"]["SocietyID"] ?? 0;
        detail.SocietySupervisorName = values["Detail"]["SocietySupervisorName"] ?? "";
        detail.SocietySupervisorImage = values["Detail"]["SocietySupervisorImage"] ?? "";
        detail.SocietyPresidentName = values["Detail"]["SocietyPresidentName"] ?? "";
        detail.SocietyPresidentImage = values["Detail"]["SocietyPresidentImage"] ?? "";
        detail.SocietyVicePresidentName = values["Detail"]["SocietyVicePresidentName"] ?? "";
        detail.SocietyVicePresidentImage = values["Detail"]["SocietyVicePresidentImage"] ?? "";
        detail.SocietyFinanceSecreteryName = values["Detail"]["SocietyFinanceSecreteryName"] ?? "";
        detail.SocietyFinanceSecreteryImage = values["Detail"]["SocietyFinanceSecreteryImage"] ?? "";
        societyandDetails.society = society;
        societyandDetails.detail = detail;
       

      // }
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
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: isload
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.6,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Image.network(
                              "http://eventsphere.somee.com/SocietyDetailsImages/${societyandDetails.society.ImageURL}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
                              stops: const [0.0, 1.0],
                            ),
                          ),
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
                                    GestureDetector(child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.explore,
                                        color: Colors.black,
                                      ),
                                    ), onTap: (){
                                      Navigator.pushNamed(context, '/Eventlist', arguments: societyandDetails.society.ID);
                                    },),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: MediaQuery.of(context).size.height *
                                      0.2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        societyandDetails
                                            .society.SocietyName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                        ),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView(
                      children: [
                        _buildPersonCard(
                          'Supervisor',
                          societyandDetails.detail.SocietySupervisorName,
                          societyandDetails.detail.SocietySupervisorImage,
                        ),
                        _buildPersonCard(
                          'President',
                          societyandDetails.detail.SocietyPresidentName,
                          societyandDetails.detail.SocietyPresidentImage,
                        ),
                        _buildPersonCard(
                          'Vice President',
                          societyandDetails.detail.SocietyVicePresidentName,
                          societyandDetails.detail.SocietyVicePresidentImage,
                        ),
                        _buildPersonCard(
                          'Finance Secretary',
                          societyandDetails.detail.SocietyFinanceSecreteryName,
                          societyandDetails.detail.SocietyFinanceSecreteryImage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPersonCard(String role, String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: ListTile(
          leading: imageUrl == null || imageUrl == ""? Image.asset('assets/user.png') : Image.network("http://EventSphere.somee.com/SocietyDetailsImages/${imageUrl}", width: 50, height: 50, fit: BoxFit.cover),
          title: Text(name),
          subtitle: Text(role),
        ),
      ),
    );
  }
}