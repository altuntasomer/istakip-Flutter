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
              hintText: 'Şifre',
            ),
          ),
          RaisedButton(
            onPressed: () {
              //password kontrolu olacak
              if (_passwordController.text == '123') {
                writeToFile(context, "melih:546");
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
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/session.txt');
      await file.writeAsString(password);
      print("**************lgin page");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e);
    }
  }
}
