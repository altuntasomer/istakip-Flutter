import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istakip/Category.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/Login/LoginPage.dart';
import 'package:istakip/Login/session.dart';
import 'package:istakip/ShowJob.dart';
import 'package:istakip/newJob.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String userName = "";
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SessionControl();

    List<String> categories = ["Jenerator", "UPS", "Chiller", "Isıtma"];
    List<String> images = [
      "image/electric-generator.png",
      "image/power-source.png",
      "image/chillers.png",
      "image/gas-heater.png"
    ];
    List<Job> jobs = DbHelper().Jobs();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        //centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset("image/logo_tr.png"),
                ),
              ],
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(left: 20),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(left: 20),
              child: demoCategories(categories, images),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      'Son Eklenenler',
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return demoTopRatedDr(context, jobs[index]);
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewJob()));
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle,
                        size: 60,
                        color: Colors.green,
                      ),
                      Text(
                        'İŞ EKLE',
                        style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  Widget demoCategories(List<String> categories, List<String> images) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryRoutine(
                      routines: categories,
                      images: images,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 38, 174, 192),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Rutin Kontroller",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoTopRatedDr(BuildContext context, Job job) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowJob(
                      job: job,
                    )));
      },
      child: Container(
        height: 90,
        // width: size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 90,
              width: 50,
              child: Image.asset("image/repair.png"),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      job.description,
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          job.place,
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 3, left: size.width * 0.25),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  job.date,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SessionControl() async {
    String content = "";

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/session.txt');
    content = await file.readAsString();

    if (content.length < 3) {
      print("homepage");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print("else");
      var lines = content.split(':');
      setState(() {
        userName = lines[1];
      });

      return content;
    }
  }
}
