import 'dart:io';

import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/newJob.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../HomePage.dart';
import 'package:istakip/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 174, 192),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("image/logo.jpg"),
            width: size.width * 0.8,
            height: size.height * 0.3,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Container(
              width: size.width / 70 * 67,
              child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Kullanıcı Kodu',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                controller: passwordController,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              //password kontrolu olacak
              User user = await DbHelper().fetchUser(passwordController.text);
              if (user.id > 0) {
                globals.username = user.name;
                globals.id = user.id;
                globals.campus = user.campus;
                SessionWrite(context, user.name, user.id, user.campus);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Hata"),
                      content: Text("Kullanıcı kodu yanlış"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Tamam"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
              width: 90,
              height: 40,
              child: Center(
                child: Text(
                  'Giriş Yap',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }

  SessionWrite(
      BuildContext context, String username, int userid, String campus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setInt('userid', userid);
    prefs.setString('campus', campus);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
