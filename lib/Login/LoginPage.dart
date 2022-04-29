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
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              icon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              labelText: 'Kullanıcı Kodu',
            ),
            controller: passwordController,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              //password kontrolu olacak
              User user = await DbHelper().fetchUser(passwordController.text);
              if (user.id > 0) {
                globals.username = user.name;
                globals.id = user.id;
                SessionWrite(context, user.name, user.id);
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
            child: Text('Giriş Yap'),
          )
        ],
      ),
    );
  }

  SessionWrite(BuildContext context, String username, int userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setInt('userid', userid);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
