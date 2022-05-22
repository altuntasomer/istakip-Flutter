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
  static const String url = 'http://10.1.5.166';

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
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
  }

  uploadGeneratorImage(XFile image, int generator_id) async {
    var selectedImage = File(image.path);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${url}:8002/uploadGenerator/${generator_id}"),
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
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
  }

  uploadUpsImage(XFile image, int ups_id) async {
    var selectedImage = File(image.path);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${url}:8002/uploadUps/${ups_id}"),
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
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
  }

  uploadChillerImage(XFile image, int chiller_id) async {
    var selectedImage = File(image.path);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${url}:8002/uploadChiller/${chiller_id}"),
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
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
  }

  uploadHeaterImage(XFile image, int heater_id) async {
    var selectedImage = File(image.path);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${url}:8002/uploadHeater/${heater_id}"),
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
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
  }

  Future<List<String>> getDocumentsFolder() async {
    List<String> folders = <String>[];

    final response = await http.get(Uri.parse("${url}:8000/api/getDocuments"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            folders.add(map['folder']);
          }
        }
      }
      return folders;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

Future<List<GeneratorKind>> unfilledGenerators() async {
    List<GeneratorKind> generators = <GeneratorKind>[];

    final response = await http.get(Uri.parse("${url}:8000/api/unfilledgenerators/1"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            generators.add(GeneratorKind.fromJson(map));
          }
        }
      }
      return generators;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<UpsKind>> unfilledUps() async {
    List<UpsKind> upss = <UpsKind>[];

    final response = await http.get(Uri.parse("${url}:8000/api/unfilledupss/1"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            upss.add(UpsKind.fromJson(map));
          }
        }
      }
      return upss;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<ChillerKind>> unfilledChillers() async {
    List<ChillerKind> chillers = <ChillerKind>[];

    final response = await http.get(Uri.parse("${url}:8000/api/unfilledchillers/1"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            chillers.add(ChillerKind.fromJson(map));
          }
        }
      }
      return chillers;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

Future<List<HeaterKind>> unfilledHeaters() async {
    List<HeaterKind> heaters = <HeaterKind>[];

    final response = await http.get(Uri.parse("${url}:8000/api/unfilledheaters/1"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            heaters.add(HeaterKind.fromJson(map));
          }
        }
      }
      return heaters;
    } else {
      throw Exception('Failed to load Notify');
    }
  }

Future<List<Document>> getDocumentsByFolder(String folder) async {
    List<Document> folders = <Document>[];

    final response = await http.get(Uri.parse("${url}:8000/api/getDocumentsByFolder/${folder}"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(utf8.decode(response.bodyBytes));
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            folders.add(Document.fromJson(map));
          }
        }
      }
      return folders;
    } else {
      throw Exception('Failed to load Notify');
    }
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

  Future<Generator> getLatestGenerator() async {
    final response = await http.get(Uri.parse('${url}:8000/api/getLatestGenerator/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Generator.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return Generator(0,"","","",0,"","",0,"","","",0);
    }
  }

  Future<Ups> getLatestUps() async {
    final response = await http.get(Uri.parse('${url}:8000/api/getLatestUps/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Ups.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return Ups(0,"","","",0,"",0,"","","",0);
    }
  }

  Future<Chiller> getLatestChiller() async {
    final response = await http.get(Uri.parse('${url}:8000/api/getLatestChiller/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Chiller.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return Chiller( 0,"","","",0,"",0,"","","",0);
    }
  }

  Future<Heater> getLatestHeater() async {
    final response = await http.get(Uri.parse('${url}:8000/api/getLatestHeater/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Heater.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return Heater( 0,"","","",0,"",0,"","","","",0);
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

  newGenerator(Generator generator, BuildContext context) async {
    final response = await http.post(
      Uri.parse("${url}:8000/api/newgenerator/${globals.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "campus": generator.campus,
        "description": generator.description,
        "fuelControl": generator.fuelControl,
        "kind": generator.kind,
        "load": generator.load,
        "oil": generator.oil,
        "user_id": generator.user_id,
        "workHour": generator.workHour,
        "waterControl": generator.waterControl,
        "term": generator.term,
      }),
    );
    final snackBar = SnackBar(
      content: const Text('Generator kaydedildi'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }
        
  newUps(Ups ups, BuildContext context) async {
    final response = await http.post(
      Uri.parse("${url}:8000/api/newups/${globals.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "campus": ups.campus,
        "description": ups.description,
        "heat": ups.heat,
        "kind": ups.kind,
        "voltageIn": ups.voltageIn,
        "user_id": ups.user_id,
        "voltageOut": ups.voltageOut,
        "load": ups.load,
        "term": ups.term,
      }),
    );
    final snackBar = SnackBar(
      content: const Text('UPS kaydedildi'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  newChiller(Chiller chiller, BuildContext context) async {
    final response = await http.post(
      Uri.parse("${url}:8000/api/newchiller/${globals.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "campus": chiller.campus,
        "description": chiller.description,
        "heat": chiller.heat,
        "kind": chiller.kind,
        "gasPressure": chiller.gasPressure,
        "user_id": chiller.user_id,
        "pumpControl": chiller.pumpControl,
        "waterPressure": chiller.waterPressure,
        "term": chiller.term,
      }),
    );
    final snackBar = SnackBar(
      content: const Text('Chiller kaydedildi'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  newHeater(Heater heater, BuildContext context) async {
    final response = await http.post(
      Uri.parse("${url}:8000/api/newheater/${globals.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "campus": heater.campus,
        "description": heater.description,
        "heat": heater.heat,
        "kind": heater.kind,
        "block": heater.block,
        "user_id": heater.user_id,
        "pumpControl": heater.pumpControl,
        "fireControl": heater.fireControl,
        "waterPressure": heater.waterPressure,
        "term": heater.term,
      }),
        
    );
    final snackBar = SnackBar(
      content: const Text('Heater kaydedildi'),
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
  late int id;
  late String campus;
  late String description;
  late String fuelControl;
  late int kind;
  late String load;
  late String oil;
  late int user_id;
  late String workHour;
  late String date;
  late String waterControl;
  late int term;

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
      this.waterControl,
      this.term);

  factory Generator.fromJson(Map<String, dynamic> json) => Generator(
        json["id"],
        json["campus"],
        json["description"],
        json["fuelControl"],
        json["kind"],
        json["load"],
        json["oil"],
        json["user_id"],
        json["workHour"],
        json["date"],
        json["waterControl"],
        json["term"],
      );

  Map<String, dynamic> toJson() => {
        "campus": campus,
        "description": description,
        "fuelControl": fuelControl,
        "kind": kind,
        "load": load,
        "oil": oil,
        "user_id": user_id,
        "workHour": workHour,
        "waterControl": waterControl,
        "term": term,
      };
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
  late int id;
  late String campus;
  late String description;
  late String heat;
  late int kind;
  late String voltageIn;
  late int user_id;
  late String voltageOut;
  late String date;
  late String load;
  late int term;

  Ups(this.id, this.campus, this.description, this.heat, this.kind,
      this.voltageIn, this.user_id, this.voltageOut, this.date, this.load, this.term);

  factory Ups.fromJson(Map<String, dynamic> json) => Ups(
        json["id"],
        json["campus"],
        json["description"],
        json["heat"],
        json["kind"],
        json["voltageIn"],
        json["user_id"],
        json["voltageOut"],
        json["date"],
        json["load"],
        json["term"],
      );

  Map<String, dynamic> toJson() => {
        "campus": campus,
        "description": description,
        "heat": heat,
        "kind": kind,
        "voltageIn": voltageIn,
        "user_id": user_id,
        "voltageOut": voltageOut,
        "load": load,
        "term": term,
      };
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
  late int id;
  late String campus;
  late String description;
  late String heat;
  late int kind;
  late String gasPressure;
  late int user_id;
  late String pumpControl;
  late String date;
  late String waterPressure;
  late int term;

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
      this.waterPressure,
      this.term);

  factory Chiller.fromJson(Map<String, dynamic> json) => Chiller(
        json["id"],
        json["campus"],
        json["description"],
        json["heat"],
        json["kind"],
        json["gasPressure"],
        json["user_id"],
        json["pumpControl"],
        json["date"],
        json["waterPressure"],
        json["term"],
      );

  Map<String, dynamic> toJson() => {
        "campus": campus,
        "description": description,
        "heat": heat,
        "kind": kind,
        "gasPressure": gasPressure,
        "user_id": user_id,
        "pumpControl": pumpControl,
        "waterPressure": waterPressure,
        "term": term,
      };
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
  late int id;
  late String campus;
  late String description;
  late String heat;
  late int kind;
  late String block;
  late int user_id;
  late String pumpControl;
  late String fireControl;
  late String date;
  late String waterPressure;
  late int term;

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
      this.waterPressure,
      this.term);

  factory Heater.fromJson(Map<String, dynamic> json) => Heater(
        json["id"],
        json["campus"],
        json["description"],
        json["heat"],
        json["kind"],
        json["block"],
        json["user_id"],
        json["pumpControl"],
        json["fireControl"],
        json["date"],
        json["waterPressure"],
        json["term"],
      );

  Map<String, dynamic> toJson() => {
        "campus": campus,
        "description": description,
        "heat": heat,
        "kind": kind,
        "block": block,
        "user_id": user_id,
        "pumpControl": pumpControl,
        "fireControl": fireControl,
        "waterPressure": waterPressure,
        "term": term,
      };
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
  late int id;
  late String name;
  late String path;

  Document({required this.id, required this.name, required this.path});

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        name: json["name"],
        path: json["path"],
      );
}
