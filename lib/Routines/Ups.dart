import 'dart:io';
import 'package:flutter/material.dart';
import 'package:istakip/TakePicture.dart';
import 'package:camera/camera.dart';

class UpsPage extends StatefulWidget {
  const UpsPage({Key? key}) : super(key: key);

  @override
  State<UpsPage> createState() => UpsPageState();
}

class UpsPageState extends State<UpsPage> {
  List<XFile> photos = [];
  var oilcontrol = false;
  var watercontrol = false;
  var fuel = ["1/4", "1/2", "3/4", "Full"];

  var dropdownFuel, dropdownFuel2;
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff107163),
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
                      print("******-*-*-**-*-*-*-*");
                      print(index);
                      print("******-*-*-**-*-*-*-*");
                      return demoCategories(photos[index].path);
                    }),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.input,
                      color: Color(0xff107163),
                    ),
                    labelText: "Giriş Voltajı (V)",
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.output,
                      color: Color(0xff107163),
                    ),
                    labelText: "Çıkış Voltajı (V)",
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.charging_station_outlined,
                      color: Color(0xff107163),
                    ),
                    labelText: "Yük Seviyesi (%)",
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.thermostat,
                      color: Color(0xff107163),
                    ),
                    labelText: "Ortam sıcaklığı (°C)",
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
