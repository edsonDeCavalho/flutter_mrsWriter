import 'package:hive/hive.dart';

int gelastId(Box box){
  var lastRecord = null;
  if(box.isEmpty){
    return 0;
  }
  lastRecord = box.getAt(box.length - 1);
  return lastRecord.id;
}