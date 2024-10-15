import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogService {
  Future<File> _getLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/transaction.log');
  }

  Future<void> log(String message) async {
    final file = await _getLogFile();
    final timestamp = DateTime.now().toIso8601String();
    await file.writeAsString('[$timestamp] $message\n', mode: FileMode.append);
  }
}