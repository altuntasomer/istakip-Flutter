import 'dart:io';

import 'package:flutter/material.dart';
import 'package:istakip/newJob.dart';
import 'package:path_provider/path_provider.dart';
import '../HomePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Kullanıcı Kodu',
            ),
          ),
          RaisedButton(
            onPressed: () {
              //password kontrolu olacak
              if (_passwordController.text == '123') {
                writeToFile(context, "546:melih");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            child: Text('Giriş Yap'),
          )
        ],
      ),
    );
  }

  writeToFile(BuildContext context, String password) async {
    try {
      print("write to file girdi");
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/session.txt');
      await file.writeAsString(password);
      print("**************lgin page");
    } catch (e) {
      print(e);
    }
  }
}
