import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/Routines/Generator.dart';
import 'package:istakip/Routines/GeneratorList.dart';
import 'Routines/ChillerList.dart';
import 'DbHelper.dart';
import 'Routines/HeaterList.dart';
import 'Routines/UpsList.dart';

class CategoryRoutine extends StatefulWidget {
  final List<String> routines;
  final List<String> images;

  const CategoryRoutine(
      {Key? key, required this.routines, required this.images})
      : super(key: key);

  @override
  State<CategoryRoutine> createState() => _CategoryRoutineState();
}

class _CategoryRoutineState extends State<CategoryRoutine> {
  

  @override
  Widget build(BuildContext context) {
    return initWidget(context, widget.routines, widget.images);
  }

  Widget initWidget(
      BuildContext context, List<String> routines, List<String> images) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 94, 161, 182),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  itemCount: routines.length,
                  itemBuilder: (BuildContext context, int index) {
                    return demoTopRatedDr(
                        context, routines[index], images[index], index);
                  }),
            ),
          ),
        ],
      ),
    );
  }
  Widget demoTopRatedDr(
    BuildContext context, String routine, String image, int index) {
  var size = MediaQuery.of(context).size;
  
  return GestureDetector(
    onTap: () {
      if (routine == "Jenerator") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GeneratorList(
                      
                    )));
      } else if (routine == "UPS") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpsList(
                      
                    )));
      } else if (routine == "Chiller") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChillerList(
                      
                    )));
      } else if (routine == "Isıtma") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HeaterList(
                      
                    )));
      }
    },
    child: Container(
      height: 115,
      // width: size.width,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: _buildRow(context, routine, image),
    ),
  );
}

Widget _buildRow(BuildContext context, String routine, String image) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: <Widget>[
        Image.asset(
          image,
          width: 80,
          height: 80,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(routine,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17)),
                    ],
                  ),
                ],
              ),
              // OutlineButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => DoctorDetailPage(job: job)));
              //     },
              //     child: Text("Görüntüle")),
            ],
          ),
        ),
      ],
    ),
  );
}
}


