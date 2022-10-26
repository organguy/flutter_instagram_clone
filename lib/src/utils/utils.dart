import 'package:uuid/uuid.dart';

class Utils{
  static String makeFilePath(String fileName){
    String extension = fileName.split('.').last;
    return '${const Uuid().v4()}.$extension';
  }
}