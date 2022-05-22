import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/Routines/Generator.dart';
import 'Chiller.dart';
import 'Ups.dart';

class ChillerList extends StatefulWidget {
  

  const ChillerList({Key? key,}) : super(key: key);

  @override
  State<ChillerList> createState() => _ChillerList();
}

class _ChillerList extends State<ChillerList> {
  late Future<List<ChillerKind>> chillerKinds;
  @override
  Widget build(BuildContext context) {
    return initWidget(context, );
  }

  Widget initWidget(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    chillerKinds = DbHelper().unfilledChillers();
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
              child: FutureBuilder<List<ChillerKind>>(
                future: chillerKinds,
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
  Widget demoTopRatedDr(BuildContext context, ChillerKind chillerList) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChillerPage(id: chillerList.id,)));
    },
    child: Container(
      height: 115,
      // width: size.width,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: _buildRow(context, chillerList),
    ),
  );
}

Widget _buildRow(BuildContext context, ChillerKind chillerList) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: <Widget>[
        Image.asset(
          "image/chillers.png",
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
                      Text(chillerList.name,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17)),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ],
    ),
  );
}

}

