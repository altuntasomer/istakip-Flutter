import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Session {
  void write(String userId, String userName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/session.txt');
    await file.writeAsString(userId + ':' + userName);
  }

  //read file
  Future<String> read() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/session.txt');
    String contents = await file.readAsString();
    return contents;
  }
}
