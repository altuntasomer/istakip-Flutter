import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/TakePicture.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class NewJob extends StatefulWidget {
  const NewJob({Key? key}) : super(key: key);

  @override
  State<NewJob> createState() => _NewJobState();
}

class _NewJobState extends State<NewJob> {
  List<XFile> photos = [];
  TextEditingController placeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
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
              Container(
                height: photos.length > 0 ? 400 : 0,
                margin: EdgeInsets.only(left: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      
                      return demoCategories(photos[index].path);
                    }),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.place,
                      color: Color(0xff107163),
                    ),
                    labelText: "Mahal Adı",
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17)),
                        controller: placeController,
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.description_outlined,
                      color: Color(0xff107163),
                    ),
                    labelText: "Açıklama",
                    enabledBorder: InputBorder.none,
                    
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17)),
                        controller: descriptionController,
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              TextField(
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.alarm,
                      color: Color(0xff107163),
                    ),
                    labelText: "İş Süresi",
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17)),
                        controller: timeController,
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;

                      XFile path = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TakePictureScreen(camera: firstCamera)));
                      photos.add(path);
                      setState(() {});
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Image.asset("image/add-photo.png"),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: (){
                      DbHelper().newJob(Job(
                        "",descriptionController.text,1,placeController.text,"OK",timeController.text,1
                      ));
                    },
                    child: Icon(
                      Icons.save,
                      size: 60,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                image: FileImage(File(image)), fit: BoxFit.fill)),
      ),
    );
  }
}
