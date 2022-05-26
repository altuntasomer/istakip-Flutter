import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/Routines/Generator.dart';

class FilledGenerator extends StatefulWidget {
  final generator;
  const FilledGenerator({
    Key? key, required this.generator
  }) : super(key: key);

  @override
  State<FilledGenerator> createState() => _FilledGenerator();
}

class _FilledGenerator extends State<FilledGenerator> {
  late Future<Generator> generator;
  
  @override
  Widget build(BuildContext context) {
    return initWidget(
      context,
    );
  }

  Widget initWidget(
    BuildContext context,
  ) {
    //Size size = MediaQuery.of(context).size;
    
    Generator generator = widget.generator;
    List<String> photos = [];
    var oilcontrol = generator.oil;
    var watercontrol = generator.waterControl;
    var fuel = ["1/4", "1/2", "3/4", "Full"];
    var selectedFuel = generator.fuelControl;
    var selectedDepo = generator.load;
    var descriptionController = TextEditingController();
    var dropdownFuel, dropdownFuel2;
    var workHourController = TextEditingController();
    String oil = "";
    String water = "";

return Scaffold(
      backgroundColor:Colors.white,
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
                      
                      return demoCategories(photos[index]);
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
                  Text(selectedFuel),
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
                  Text(selectedDepo),
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
                    value: water=='' ? true : false,
                    onChanged: (bool? value) {
                      
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
                    value: oil=='' ? true : false,
                    onChanged: (bool? value) {
                      
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
                    labelText: generator.workHour,
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
                    labelText: generator.description,
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17)),
              ),
              Container(
                child: Divider(
                  color: Colors.black,
                ),
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
            
      ),
    ));
  }
}
