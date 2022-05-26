import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/Routines/Generator.dart';
import 'Chiller.dart';
import 'Heater.dart';
import 'Ups.dart';

class HeaterList extends StatefulWidget {


  const HeaterList({Key? key, }) : super(key: key);

  @override
  State<HeaterList> createState() => _HeaterList();
}

class _HeaterList extends State<HeaterList> {
  late Future<List<HeaterKind>> heaterKinds;
  @override
  Widget build(BuildContext context) {
    return initWidget(context, );
  }

  Widget initWidget(BuildContext context, ) {
    //Size size = MediaQuery.of(context).size;
    heaterKinds = DbHelper().unfilledHeaters();
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
              child: FutureBuilder<List<HeaterKind>>(
                future: heaterKinds,
                builder: (context,snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return demoTopRatedDr(context, snapshot.data![index]);
                        });
                  } else if(snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget demoTopRatedDr(BuildContext context, HeaterKind heaterList) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HeaterPage(id: heaterList.id,))).then((value) {setState(() {
            
          });});
    },
    child: Container(
      height: 115,
      // width: size.width,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: _buildRow(context, heaterList),
    ),
  );
}

Widget _buildRow(BuildContext context, HeaterKind heaterList) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: <Widget>[
        Image.asset(
          "image/gas-heater.png",
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
                      Text(heaterList.name,
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

