import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'Detail.dart';

class CategoryTrainer extends StatefulWidget {
  final List<Job> jobs;
  final int selectedCategory;

  const CategoryTrainer(
      {Key? key, required this.jobs, required this.selectedCategory})
      : super(key: key);

  @override
  State<CategoryTrainer> createState() => _CategoryTrainerState();
}

class _CategoryTrainerState extends State<CategoryTrainer> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context, widget.jobs, widget.selectedCategory);
  }

  Widget initWidget(
      BuildContext context, List<Job> jobs, int selectedCategory) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
        //centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Image.asset("image/girl.png"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return demoTopRatedDr(context, jobs[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget demoTopRatedDr(BuildContext context, Job job) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      /*Navigator.push(context,
            MaterialPageRoute(builder: (context) => DoctorDetailPage()));*/
    },
    child: Container(
      height: 115,
      // width: size.width,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: _buildRow(context, job),
      /*Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 90,
              width: 50,
              child: Image.asset(img),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        Container(
                          // Puan containeri
                          margin:
                              EdgeInsets.only(top: 3, left: size.width * 0.25),
                          child: Row(
                            children: <Widget>[
                              Container(
                              child: Text(
                                "Puan: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              ),
                              Container(
                                child: Text(
                                  rating,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),*/
    ),
  );
}

Widget _buildRow(BuildContext context, Job job) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: <Widget>[
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage("image/repair.png"),
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
                      Text(job.description,
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(job.place, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(job.user_id,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Kullanıcı", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              OutlineButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetailPage(job: job)));
                  },
                  child: Text("Görüntüle")),
            ],
          ),
        ),
      ],
    ),
  );
}
