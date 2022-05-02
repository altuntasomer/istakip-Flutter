import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class DbHelper {
  static const String url = 'http://192.168.1.110';

  uploadImage(XFile image, int job_id) async {
    var selectedImage = File(image.path);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${url}:8002/upload/${job_id}"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: selectedImage.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
  }

  Future<List<String>> getJobImages(job_id) async {
    List<String> urls = <String>[];

    final response = await http.get(Uri.parse("${url}:8000/api/getjobimages/${job_id}"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            urls.add(map['image_url']);
          }
        }
      }
      return urls;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  Future<Job> getLatestJob() async {
    final response = await http.get(Uri.parse('${url}:8000/api/getLatestJob/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Job.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return Job("", "", 0, "", "", "", 0);
    }
  }

  Future<User> fetchUser(String password) async {
    final response = await http.get(
        Uri.parse('${url}:8000/api/userspass/${password}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return User(0, "", "", "");
    }
  }

  Future<List<Notify>> fetchNotify() async {
    List<Notify> notifies = <Notify>[];

    final response = await http.get(Uri.parse("${url}:8000/api/notifications"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            notifies.add(Notify.fromJson(map));
          }
        }
      }
      return notifies;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<Job>> fetchJob() async {
    List<Job> jobs = <Job>[];

    final response = await http.get(
      Uri.parse("${url}:8000/api/jobs"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            jobs.add(Job.fromJson(map));
          }
        }
      }
      return jobs;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  newJob(Job job, BuildContext context) async {
    final response = await http.post(
      Uri.parse("${url}:8000/api/newJob/${globals.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "description": job.description,
        "place": job.place,
        "status": job.status,
        "time": job.time,
        "user_id": job.userid,
      }),
    );
    final snackBar = SnackBar(
      content: const Text('İş kaydedildi'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  Future<List<GeneratorKind>> fetchGeneratorKind() async {
    List<GeneratorKind> notifies = <GeneratorKind>[];

    final response =
        await http.get(Uri.parse("${url}:8000/api/generatorKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            notifies.add(GeneratorKind.fromJson(map));
          }
        }
      }
      return notifies;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<UpsKind>> fetchUpsKind() async {
    List<UpsKind> notifies = <UpsKind>[];

    final response = await http.get(Uri.parse("${url}:8000/api/upsKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            notifies.add(UpsKind.fromJson(map));
          }
        }
      }
      return notifies;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<ChillerKind>> fetchChillerKind() async {
    List<ChillerKind> notifies = <ChillerKind>[];

    final response = await http.get(Uri.parse("${url}:8000/api/chillerKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            notifies.add(ChillerKind.fromJson(map));
          }
        }
      }
      return notifies;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<HeaterKind>> fetchHeaterKind() async {
    List<HeaterKind> notifies = <HeaterKind>[];

    final response = await http.get(Uri.parse("${url}:8000/api/heaterKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            notifies.add(HeaterKind.fromJson(map));
          }
        }
      }
      return notifies;
    } else {
      throw Exception('Failed to load Notify');
    }
  }
}

class Job {
  late String date;
  late String description;
  late int id;
  late String place;
  late String status;
  late String time;
  late int userid;

  Job(this.date, this.description, this.id, this.place, this.status, this.time,
      this.userid);

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        json["date"],
        json["description"],
        json["id"],
        json["place"],
        json["status"],
        json["time"],
        json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "place": place,
        "status": status,
        "time": time,
        "userid": userid,
      };
}

class Generator {
  late String id;
  late String campus;
  late String description;
  late String fuelControl;
  late String kind;
  late String load;
  late String oil;
  late String user_id;
  late String workHour;
  late String date;
  late String waterControl;

  Generator(
      this.id,
      this.campus,
      this.description,
      this.fuelControl,
      this.kind,
      this.load,
      this.oil,
      this.user_id,
      this.workHour,
      this.date,
      this.waterControl);
}

class GeneratorKind {
  late int id;
  late String name;
  late String campus;

  factory GeneratorKind.fromJson(Map<String, dynamic> json) => GeneratorKind(
        json["id"],
        json["name"],
        json["campus"],
      );

  GeneratorKind(this.id, this.name, this.campus);
}

class Ups {
  late String id;
  late String campus;
  late String description;
  late String heat;
  late String kind;
  late String voltageIn;
  late String user_id;
  late String voltageOut;
  late String date;
  late String load;

  Ups(this.id, this.campus, this.description, this.heat, this.kind,
      this.voltageIn, this.user_id, this.voltageOut, this.date, this.load);
}

class UpsKind {
  late int id;
  late String name;
  late String campus;

  factory UpsKind.fromJson(Map<String, dynamic> json) => UpsKind(
        json["id"],
        json["name"],
        json["campus"],
      );

  UpsKind(this.id, this.name, this.campus);
}

class Chiller {
  late String id;
  late String campus;
  late String description;
  late String heat;
  late String kind;
  late String gasPressure;
  late String user_id;
  late String pumpControl;
  late String date;
  late String waterPressure;

  Chiller(
      this.id,
      this.campus,
      this.description,
      this.heat,
      this.kind,
      this.gasPressure,
      this.user_id,
      this.pumpControl,
      this.date,
      this.waterPressure);
}

class ChillerKind {
  late int id;
  late String name;
  late String campus;

  factory ChillerKind.fromJson(Map<String, dynamic> json) => ChillerKind(
        json["id"],
        json["name"],
        json["campus"],
      );

  ChillerKind(this.id, this.name, this.campus);
}

class Heater {
  late String id;
  late String campus;
  late String description;
  late String heat;
  late String kind;
  late String block;
  late String user_id;
  late String pumpControl;
  late String fireControl;
  late String date;
  late String waterPressure;

  Heater(
      this.id,
      this.campus,
      this.description,
      this.heat,
      this.kind,
      this.block,
      this.user_id,
      this.pumpControl,
      this.fireControl,
      this.date,
      this.waterPressure);
}

class HeaterKind {
  late int id;
  late String name;
  late String campus;

  factory HeaterKind.fromJson(Map<String, dynamic> json) => HeaterKind(
        json["id"],
        json["name"],
        json["campus"],
      );

  HeaterKind(this.id, this.name, this.campus);
}

class User {
  late int id;
  late String name;
  late String password;
  late String campus;

  User(
    this.id,
    this.name,
    this.password,
    this.campus,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        json["id"],
        json["name"],
        json["password"],
        json["campus"],
      );
}

class Notify {
  late int id;
  late String description;
  late String date;

  Notify({required this.id, required this.description, required this.date});

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        id: json["id"],
        description: json["description"],
        date: json["date"],
      );
}

class Document {
  late String id;
  late String name;
  late String path;

  Document({required this.id, required this.name, required this.path});
}
