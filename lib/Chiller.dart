import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chiller extends StatelessWidget {
  final campus;
  final kind;
  const Chiller({Key? key, @required this.campus, this.kind}) : super(key: key);

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
                "SOĞUTMA SİSTEMİ",
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
        body: chillerWidget());
  }
}

class chillerWidget extends StatefulWidget {
  const chillerWidget({Key? key}) : super(key: key);

  @override
  State<chillerWidget> createState() => _chillerWidgetState();
}

class _chillerWidgetState extends State<chillerWidget> {
  var kampus = ["Küçükyalı", "Sütlüce"];
  var place = ["A Blok 1 No'lu Kazan Dairesi", "B Blok 5 No'lu Kazan Dairesi"];

  var pompaKontrolu = false;
  var dropdownKampus;
  var dropdownMevki;
  var dropdownPlace;

  TextEditingController aciklama = new TextEditingController();
  TextEditingController suBasinci = new TextEditingController();
  TextEditingController gazBasinci = new TextEditingController();
  TextEditingController sicaklik = new TextEditingController();

  void initState() {
    dropdownKampus = this.kampus.first;

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
              items: place.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
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
              value: this.pompaKontrolu,
              onChanged: (bool? value) {
                setState(() {
                  this.pompaKontrolu = value!;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Gaz Basıncı:"),
            Container(
                width: 100.0,
                child: TextField(
                  controller: gazBasinci,
                )),
            Text("Bar"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Su Basıncı:"),
            Container(
                width: 100.0,
                child: TextField(
                  controller: suBasinci,
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
                  controller: sicaklik,
                )),
            Text("°C"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: aciklama,
          onChanged: (text) {
            print(aciklama.text);
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
