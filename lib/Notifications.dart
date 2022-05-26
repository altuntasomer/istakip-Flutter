import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';

class Notifications extends StatefulWidget {
  const Notifications({ Key? key }) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late Future<List<Notify>> notifications;
  void initState() {
    super.initState();
    notifications = DbHelper().fetchNotify();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Notify>>(
            future: notifications,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return demoTopRatedDr(context, snapshot.data![index]);
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
    );}


  Widget demoTopRatedDr(BuildContext context, Notify notification) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        width: size.width-40,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 90,
            // width: size.width,
            
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 90,
                  width: 50,
                  child: Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xff363636),
                    size: 30,
                  ),
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
                          notification.description,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
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
                              notification.date.split(':')[0].replaceAll('T', '  ') + ":" + notification.date.split(':')[1],
                              style: TextStyle(
                                color: Color(0xffababab),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: 18
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}