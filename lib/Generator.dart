
import 'package:flutter/material.dart';

class GeneratorPage extends StatelessWidget {
  
  const GeneratorPage({Key? key,}) : super(key: key);

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
                "JENERATÖR",
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
        body: MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var kampus = ["Küçükyalı","Sütlüce"];
  var tur = ["110","125"];
  var yakitkontrolu = ["1/4","1/2"];
  var yedekdepo = ["1/4","1/2"];
  var sogutmasuyu = false;
  var yagkontrolu = false;
  var yedekdepoDropValue;
  var yakitkontroluDropValue;

  var dropdownKampus;
  var dropdownTur;


  TextEditingController calismaSaati = new TextEditingController();

  void initState() {
    dropdownKampus = this.kampus.first;
    dropdownTur = this.tur.first;
    yakitkontroluDropValue = this.yakitkontrolu.first;
    yedekdepoDropValue = this.yedekdepo.first;
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
              items: kampus
                  .map<DropdownMenuItem<String>>((String value) {
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
              items: tur
                  .map<DropdownMenuItem<String>>((String value) {
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
            Text("Yakıt Seviyesi Kontrolü:"),
            DropdownButton<String>(
              value: yakitkontroluDropValue,
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
                  yakitkontroluDropValue = newValue!;
                });
              },
              items: yakitkontrolu
                  .map<DropdownMenuItem<String>>((String value) {
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
            Text("Yedek Depo Seviyesi:"),
            DropdownButton<String>(
              value: yakitkontroluDropValue,
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
                  yedekdepoDropValue = newValue!;
                });
              },
              items: yedekdepo
                  .map<DropdownMenuItem<String>>((String value) {
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
            Text("Soğutma Suyu Kontrolü"),
            SizedBox(width: 10,),
            Checkbox(value: this.sogutmasuyu, onChanged: (bool ? value){
              setState(() {
                this.sogutmasuyu = value!;
              });
            },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Yağ Kontrolü"),
            SizedBox(width: 10,),
            Checkbox(value: this.yagkontrolu, onChanged: (bool ? value){
              setState(() {
                this.yagkontrolu = value!;
              });
            },
            )
          ],
        ),
        TextField(
          controller: calismaSaati,
          onChanged: (text){
            print(calismaSaati.text);
          },
          decoration: InputDecoration(
            hintText: "Çalışma Saati",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
          ),
        ),
        TextField(
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
