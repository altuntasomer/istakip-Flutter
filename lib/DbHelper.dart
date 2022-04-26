import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class DbHelper {

  static const String url = 'http://192.168.1.113';
  

  Future<List<Notify>> fetchNotify() async{
    List<Notify> notifies = <Notify>[];

    
    final response = await http.get(Uri.parse("$url:8000/api/notifications"));

    if (response.statusCode == 200) {
      List<dynamic> values=<dynamic>[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            notifies.add(Notify.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      }
      return notifies;
    } else {
      
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<Job>> fetchJob() async{
    List<Job> jobs = <Job>[];

    
    final response = await http.get(Uri.parse("$url:8000/api/jobs"));

    if (response.statusCode == 200) {
      List<dynamic> values=<dynamic>[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            jobs.add(Job.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      }
      return jobs;
    } else {
      print("b");
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<GeneratorKind>> fetchGeneratorKind() async{
    List<GeneratorKind> notifies = <GeneratorKind>[];

    
    final response = await http.get(Uri.parse("$url:8000/api/generatorKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values=<dynamic>[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            notifies.add(GeneratorKind.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      }
      return notifies;
    } else {
      
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<UpsKind>> fetchUpsKind() async{
    List<UpsKind> notifies = <UpsKind>[];

    
    final response = await http.get(Uri.parse("$url:8000/api/upsKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values=<dynamic>[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            notifies.add(UpsKind.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      }
      return notifies;
    } else {
      
      throw Exception('Failed to load Notify');
    }
  }  
 
 Future<List<ChillerKind>> fetchChillerKind() async{
    List<ChillerKind> notifies = <ChillerKind>[];

    
    final response = await http.get(Uri.parse("$url:8000/api/chillerKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values=<dynamic>[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            notifies.add(ChillerKind.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      }
      return notifies;
    } else {
      
      throw Exception('Failed to load Notify');
    }
  }

  Future<List<HeaterKind>> fetchHeaterKind() async{
    List<HeaterKind> notifies = <HeaterKind>[];

    
    final response = await http.get(Uri.parse("$url:8000/api/heaterKinds"));

    if (response.statusCode == 200) {
      List<dynamic> values=<dynamic>[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            notifies.add(HeaterKind.fromJson(map));
            debugPrint('Id-------${map['id']}');
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
  late int user_id;

  Job(this.date, this.description, this.id, this.place, this.status, this.time,
      this.user_id);

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    
        json["date"],
        json["description"],
        json["id"],
        json["place"],
        json["status"],
        json["time"],
        json["user_id"],
      );
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
  late String id;
  late String name;
  late String surname;
  late String email;
  late String password;
  late String role;
  late String campus;
  late String department;
  late String phone;
  late String image;

  User(
      this.id,
      this.name,
      this.surname,
      this.email,
      this.password,
      this.role,
      this.campus,
      this.department,
      this.phone,
      this.image);
}

class Notify{
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

class Document{
  late String id;
  late String name;
  late String path;

  Document({required this.id, required this.name, required this.path});
  
}