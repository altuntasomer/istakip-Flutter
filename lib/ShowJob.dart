import 'dart:io';

import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/TakePicture.dart';
import 'package:camera/camera.dart';

class ShowJob extends StatefulWidget {
  final job;
  const ShowJob({Key? key, this.job}) : super(key: key);

  @override
  State<ShowJob> createState() => _ShowJobState();
}

class _ShowJobState extends State<ShowJob> {
  late Future<List<String>> urls;
  @override
  Widget build(BuildContext context) {
    return initScreen(context, widget.job);
  }

  Widget initScreen(BuildContext context, Job job) {
    Size size = MediaQuery.of(context).size;
    urls = DbHelper().getJobImages(job.id);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              FutureBuilder<List<String>>(
                future: urls,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 400,
                      margin: EdgeInsets.only(left: 20),
                      child: Container(
                        height: snapshot.data!.length > 0 ? 400 : 0,
                        margin: EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return demoCategories(snapshot.data![index]);
                            }),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.place,
                      color: Color(0xff107163),
                    ),
                    labelText: job.place,
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17)),
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              TextField(
                enabled: false,
                obscureText: false,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.description_outlined,
                      color: Color(0xff107163),
                    ),
                    labelText: job.description,
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17)),
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              TextField(
                enabled: false,
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.alarm,
                      color: Color(0xff107163),
                    ),
                    labelText: job.time,
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17)),
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget demoCategories(String image) {
    return GestureDetector(
      child: Container(
        width: 300,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(image), fit: BoxFit.fill)),
      ),
    );
  }
}
