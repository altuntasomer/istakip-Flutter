import 'dart:io';
import 'package:flutter/material.dart';
import 'package:istakip/TakePicture.dart';
import 'package:camera/camera.dart';

import '../DbHelper.dart';

class HeaterPage extends StatefulWidget {
  final id;
  const HeaterPage({Key? key, required this.id}) : super(key: key);

  @override
  State<HeaterPage> createState() => HeaterPageState();
}

class HeaterPageState extends State<HeaterPage> {
  List<XFile> photos = [];
  var oilcontrol = false;
  var pumpcontrol = false;
  var firecontrol = false;
  var descriptionController = TextEditingController();
  var heatController = TextEditingController();
  var pressureController = TextEditingController();
  

  String pump = '0';
  String fire = '0';

  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  Text("Alev Kontrolü"),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Checkbox(
                    value: firecontrol,
                    onChanged: (bool? value) {
                      if (value == true) {
                        fire = '1';
                      } else {
                        fire = '0';
                      }
                      setState(() {
                        firecontrol = value!;

                      });
                    },
                  ),
                  SizedBox(
                    width: 90,
                  ),
                ],
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  Text("Pompa Kontrolü"),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Checkbox(
                    value: pumpcontrol,
                    onChanged: (bool? value) {
                      if (value == true) {
                        pump = '1';
                      } else {
                        pump = '0';
                      }
                      setState(() {
                        pumpcontrol = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 90,
                  ),
                ],
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              TextField(
                obscureText: false,
                controller: pressureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.charging_station_outlined,
                      color: Color(0xff107163),
                    ),
                    labelText: "Su Basıncı (Bar)",
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
                obscureText: false,
                controller: heatController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.thermostat,
                      color: Color(0xff107163),
                    ),
                    labelText: "Tesisat sıcaklığı (°C)",
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
                obscureText: false,
                controller: descriptionController,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.description_outlined,
                      color: Color(0xff107163),
                    ),
                    labelText: "Açıklama",
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
                    onTap: () async {
                      DbHelper().newHeater(Heater(1,"campus",descriptionController.text,heatController.text,widget.id,"d",1,pump,fire,"g",pressureController.text,1), context).then((value) async{
                        Heater heater = await DbHelper().getLatestHeater();
                        print(heater.id);
                        for(int i = 0; i < photos.length; i++){
                          await DbHelper().uploadHeaterImage(photos[i], heater.id);
                        }
                      });
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
