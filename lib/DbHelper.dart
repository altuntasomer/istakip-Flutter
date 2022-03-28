import 'package:flutter/material.dart';

class DbHelper {
  List<Category> Categories() {
    Category category = Category(1, "image/repair.png", "İş", 0);
    Category category2 =
        Category(1, "image/electric-generator.png", "Rutin Kontroller", 0);
    
    List<Category> categories = List<Category>.filled(2, category);
    categories[0] = category;
    categories[1] = category2;
    
    return categories;
  }

  List<Job> Jobs() {
    Job job = Job(
        "23.04.2020:12.24", "priz tamir edildi", "1", "E505", "1", "15", "1");
    Job job2 = Job(
        "22.04.2020:09.45", "ampul değiştirildi", "2", "E502", "1", "20", "1");
    Job job3 = Job("21.04.2020:11.15", "jeneratör arızası giderildi", "3",
        "E503", "1", "10", "1");
    Job job4 =
        Job("20.04.2020:08.41", "santral arızası", "4", "E504", "1", "35", "1");
    Job job5 = Job(
        "23.04.2020:15.25", "bayrak değiştirildi", "5", "E508", "1", "25", "1");
    List<Job> jobs = List<Job>.filled(5, job);
    jobs[0] = job;
    jobs[1] = job2;
    jobs[2] = job3;
    jobs[3] = job4;
    jobs[4] = job5;
    return jobs;
  }
}

class Category {
  late int id;
  late String img;
  late String name;
  late int trainerCount;

  Category(this.id, this.img, this.name, this.trainerCount);
}

class Job {
  late String date;
  late String description;
  late String id;
  late String place;
  late String status;
  late String time;
  late String user_id;

  Job(this.date, this.description, this.id, this.place, this.status, this.time,
      this.user_id);
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
