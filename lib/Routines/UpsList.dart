import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/Routines/Generator.dart';
import 'Ups.dart';

class UpsList extends StatefulWidget {

  const UpsList({Key? key}) : super(key: key);

  @override
  State<UpsList> createState() => _UpsList();
}

class _UpsList extends State<UpsList> {
  late Future<List<UpsKind>> upsKinds;

  @override
  Widget build(BuildContext context) {
    return initWidget(context,);
  }

  Widget initWidget(BuildContext context,) {
    //Size size = MediaQuery.of(context).size;
    upsKinds = DbHelper().unfilledUps();
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
              child: FutureBuilder<List<UpsKind>>(
                future: upsKinds,
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
  Widget demoTopRatedDr(BuildContext context, UpsKind upsList) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UpsPage(id: upsList.id,))).then((value) {setState(() {
            
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
      child: _buildRow(context, upsList),
    ),
  );
}

Widget _buildRow(BuildContext context, UpsKind upsList) {
  return Container(
    
    padding: const EdgeInsets.all(16),
    child: Row(
      children: <Widget>[
        Image.asset(
          "image/power-source.png",
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
                      Text(upsList.name,
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
              //     child: Text("G??r??nt??le")),
            ],
          ),
        ),
      ],
    ),
  );
}

}

