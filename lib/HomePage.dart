import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istakip/Category.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/Documents.dart';
import 'package:istakip/Login/LoginPage.dart';
import 'package:istakip/Login/session.dart';
import 'package:istakip/ShowJob.dart';
import 'package:istakip/newJob.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Notifications.dart';
import 'globals.dart' as globals;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  late Future<List<Job>> jobs;
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if(globals.s == false)
    {
      SessionControl();
      globals.s = true;
    }
    

    List<String> categories = ["Jenerator", "UPS", "Chiller", "Isıtma"];
    List<String> images = [
      "image/electric-generator.png",
      "image/power-source.png",
      "image/chillers.png",
      "image/gas-heater.png"
    ];
    jobs = DbHelper().fetchJob();
    
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(globals.username),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: 150,
                  child: Image.asset("image/logo_tr.png"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("YAPI VE TEKNİK İŞLER MÜDÜRLÜĞÜ", style: TextStyle(fontWeight: FontWeight.w700),),
              ],
            ),
            SizedBox(
              height: 20,
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
                      'Yapılan İşler',
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
                child: FutureBuilder<List<Job>>(
                  future: jobs,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return demoTopRatedDr(context, snapshot.data![index]);
                      });
                    }
                  
                  else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                  }
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Documents()));
                  },
                  child: Icon(
                    Icons.file_copy,
                    color: Color.fromARGB(255, 94, 161, 182),
                    size: 40,
                  ),
                ),
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
                GestureDetector(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Notifications())),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    color: Color.fromARGB(255, 94, 161, 182),
                    size: 40,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('userid');
    String? username = prefs.getString('username');
    int? userid = prefs.getInt('userid');
    if (username == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    else{
      globals.id = userid!;
      globals.username = username;
      setState(() {
        
      });
    }
    return "Success";
  }

  
}
