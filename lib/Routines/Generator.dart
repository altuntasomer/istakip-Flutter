import 'dart:io';
import 'package:flutter/material.dart';
import 'package:istakip/TakePicture.dart';
import 'package:camera/camera.dart';

import '../DbHelper.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  List<XFile> photos = [];
  var oilcontrol = false;
  var watercontrol = false;
  var fuel = ["1/4", "1/2", "3/4", "Full"];
  var descriptionController = TextEditingController();
  var dropdownFuel, dropdownFuel2;
  var workHourController = TextEditingController();
  String oil = "";
  String water = "";
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 94, 161, 182),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  Text("Yakıt Seviyesi"),
                  Expanded(child: SizedBox()),
                  DropdownButton<String>(
                    value: dropdownFuel2,
                    //icon: const Icon(Icons.thumb_down_alt),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownFuel2 = newValue!;
                      });
                    },
                    items: fuel.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  Text("Yedek Depo Seviyesi"),
                  Expanded(child: SizedBox()),
                  DropdownButton<String>(
                    value: dropdownFuel,
                    //icon: const Icon(Icons.thumb_down_alt),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownFuel = newValue!;
                      });
                    },
                    items: fuel.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                  Text("Soğutma Suyu Kontrolü"),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Checkbox(
                    value: watercontrol,
                    onChanged: (bool? value) {
                      setState(() {
                        watercontrol = value!;
                        if (value) {
                          water = "1";
                        }
                        else {
                          water = "0";
                        }
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  Text("Yağ Kontrolü"),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Checkbox(
                    value: oilcontrol,
                    onChanged: (bool? value) {
                      setState(() {
                        oilcontrol = value!;
                        if(value){
                          oil = "1";
                        }else{
                          oil = "0";
                        }
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
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.place,
                      color: Color(0xff107163),
                    ),
                    labelText: "Jeneratör gücü",
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
                controller: workHourController,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.alarm,
                      color: Color(0xff107163),
                    ),
                    labelText: "Çalışma Saati",
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
                      DbHelper().newGenerator(Generator(1,"campus",descriptionController.text,dropdownFuel.toString(),1,dropdownFuel2.toString(),oil,1,workHourController.text,"g",water,1), context).then((value) async{
                        
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
