import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpsPage extends StatelessWidget {
  final campus;
  final kind;
  const UpsPage({Key? key, @required this.campus, this.kind}) : super(key: key);

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
                "UPS",
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
        body: upsWidget());
  }
}

class upsWidget extends StatefulWidget {
  const upsWidget({Key? key}) : super(key: key);

  @override
  State<upsWidget> createState() => _upsWidgetState();
}

class _upsWidgetState extends State<upsWidget> {
  var kampus = ["Küçükyalı", "Sütlüce"];
  var tur = ["110", "125"];

  var dropdownKampus;
  var dropdownTur;

  TextEditingController aciklama = new TextEditingController();
  TextEditingController girisVoltaj = new TextEditingController();
  TextEditingController cikisVoltaj = new TextEditingController();
  TextEditingController yukSeviyesi = new TextEditingController();
  TextEditingController sicaklik = new TextEditingController();

  void initState() {
    dropdownKampus = this.kampus.first;
    dropdownTur = this.tur.first;
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
              value: dropdownTur,
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
                  dropdownTur = newValue!;
                });
              },
              items: tur.map<DropdownMenuItem<String>>((String value) {
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
            Text("Giriş Voltajı:"),
            Container(
                width: 100.0,
                child: TextField(
                  controller: girisVoltaj,
                )),
            Text("V")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Çıkış Voltajı:"),
            Container(
                width: 100.0,
                child: TextField(
                  controller: cikisVoltaj,
                )),
            Text("V"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Yük Seviyesi"),
            Container(
                width: 100.0,
                child: TextField(
                  controller: yukSeviyesi,
                )),
            Text("%"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Ortam Sıcaklığı:"),
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
