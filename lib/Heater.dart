import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Heater extends StatelessWidget {
  final campus;
  final kind;
  final position;
  const Heater({Key? key, @required this.campus, this.kind, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "ISITMA SİSTEMİ",
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: ButtonTheme(
                    minWidth: 0.0,
                    height: 50.0,
                    highlightColor: Colors.orange,
                    buttonColor:
                        Theme.of(context).primaryColor.withOpacity(1.0),
                    child: RaisedButton(
                      child: Text("Kaydet"),
                      onPressed: () {
                        // fonksiyon gelecek
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )),
          ],
        ),
        body: heaterWidget());
  }
}

class heaterWidget extends StatefulWidget {
  const heaterWidget({Key? key}) : super(key: key);

  @override
  State<heaterWidget> createState() => _heaterWidgetState();
}

class _heaterWidgetState extends State<heaterWidget> {
  var kampus = ["Küçükyalı", "Sütlüce"];
  var mevki = ["110", "125"];
  var place = ["A Blok 1 No'lu Kazan Dairesi", "B Blok 5 No'lu Kazan Dairesi"];

  var alevkontrol = false;
  var pompakontrol = false;

  var dropdownKampus;
  var dropdownMevki;
  var dropdownPlace;

  TextEditingController aciklamaHeater = new TextEditingController();
  TextEditingController subasinci = new TextEditingController();
  TextEditingController tesisatsicakligi = new TextEditingController();

  void initState() {
    dropdownKampus = this.kampus.first;
    dropdownMevki = this.mevki.first;
    dropdownPlace = this.place.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              value: dropdownKampus,
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
                  dropdownKampus = newValue!;
                });
              },
              items: kampus.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: dropdownMevki,
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
                            dropdownMevki = newValue!;
                          });
                        },
                        items:
                            mevki.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: dropdownPlace,
                        //icon: const Icon(Icons.thumb_down_alt),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownPlace = newValue!;
                          });
                        },
                        items:
                            place.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Alev Kontrolü"),
            SizedBox(
              width: 10,
            ),
            Checkbox(
              value: this.alevkontrol,
              onChanged: (bool? value) {
                setState(() {
                  this.alevkontrol = value!;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Pompa Kontrolü"),
            SizedBox(
              width: 10,
            ),
            Checkbox(
              value: this.pompakontrol,
              onChanged: (bool? value) {
                setState(() {
                  this.pompakontrol = value!;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Su Basıncı:"),
            Container(
                width: 100.0,
                child: TextField(
                  controller: subasinci,
                )),
            Text("Bar"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Tesisat Sıcaklığı:"),
            Container(
                width: 100.0,
                child: TextField(
                  controller: tesisatsicakligi,
                )),
            Text("°C"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: aciklamaHeater,
          onChanged: (text) {
            print(aciklamaHeater.text);
          },
          decoration: InputDecoration(
            hintText: "Açıklama",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              width: 150,
              height: 150,
            ),
            const SizedBox(width: 65.0),
            const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              width: 150,
              height: 150,
            ),
          ],
        ),
      ],
    );
  }
}
