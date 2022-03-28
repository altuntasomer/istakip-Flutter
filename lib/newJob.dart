import 'package:flutter/material.dart';

class NewJob extends StatefulWidget {
  const NewJob({Key? key}) : super(key: key);

  @override
  State<NewJob> createState() => _NewJobState();
}

class _NewJobState extends State<NewJob> {
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff107163),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff107163),
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
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Merhaba",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 25,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      'Kategori',
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 320,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return demoCategories("image/power-source.png");
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.place,
                    color: Color(0xff107163),
                  ),
                  labelText: "Mahal Adı",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey)),
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
                  labelStyle: const TextStyle(color: Colors.grey)),
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
                    Icons.alarm,
                    color: Color(0xff107163),
                  ),
                  labelText: "Tamamlama Süresi",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
            Container(
              child: Divider(
                color: Colors.black,
              ),
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff107163),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 100,
                    height: 40,
                    child: Text("Kaydet"),
                  ),
                ),
                SizedBox(width: 40,)
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget demoCategories(String uri) {
    return GestureDetector(
      child: Container(
        width: 320,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Color(0xff107163),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(uri, height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
