import 'dart:convert';
import 'package:eventsphere/addEvent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _signature = TextEditingController();
  TextEditingController _password = TextEditingController();
  int index = 0;

  Future<void> login() async {
    final String email = _signature.text;
    final String password = _password.text;

    final response = await http.get(
      Uri.parse('http://eventsphere.somee.com/Society/Login?email=$email&password=$password'),
    );

    if (response.statusCode == 200) {
      var values = json.decode(response.body);

      if (values["ID"] == -1) {
        _showMessage('Invalid user');
      } else if (values["ID"] == -2) {
        _showMessage('Community not active');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventScreen(
              id: values["ID"],
            ),
          ),
        );
      }
    } else {
      _showMessage('Failed to login');
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            Container(
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
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 1,
              child: const SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello,",
                            style: TextStyle(
                                color: Colors.white, fontSize: 45),
                          ),
                          Text(
                            'Sign in to continue!',
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color.fromRGBO(211, 228, 246, 1.0)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.black))),
                            child: TextField(
                              controller: _signature,
                              cursorColor: Colors.black,
                              style:
                                  const TextStyle(color: Colors.blueGrey),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.check),
                                suffixIconColor: Colors.black,
                                hintText: "example@exmaple.com",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle:
                                    TextStyle(color: Colors.blueGrey),
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.black))),
                            child: TextField(
                              controller: _password,
                              cursorColor: Colors.black,
                              style:
                                  const TextStyle(color: Colors.blueGrey),
                              obscureText: index == 0 ? true : false,
                              decoration: InputDecoration(
                                suffixIconColor: Colors.black,
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintStyle: const TextStyle(
                                    color: Colors.black),
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                suffixIcon: index == 0
                                    ? IconButton(
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            index = 1;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon:
                                            const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            index = 0;
                                          });
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
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
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        login();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
