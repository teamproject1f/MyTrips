import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String daysBetween(DateTime postDate){
  if  ((DateTime.now().difference(postDate).inHours / 24).round() == 0)
  {
    if(DateTime.now().difference(postDate).inHours == 0 ) {
      if(DateTime.now().difference(postDate).inMinutes == 0) {
        return 'now';
      }
      else {
        return '${DateTime.now().difference(postDate).inMinutes.toString()} minutes';
      }
    }
    else {
      return '${DateTime.now().difference(postDate).inHours.toString()} hours';
    }
  } else {
    return (' ${(DateTime.now().difference(postDate).inHours / 24).round().toString()} days');
  }


}
String getDate () {
  DateTime dateTime =  DateTime.now();
  String date =  DateFormat.yMMMd().format(dateTime);
  return date;
}
String getNowDateTime (Timestamp dateTime) {
  String date =DateFormat.yMd().format(dateTime.toDate()).toString();
  String time = DateFormat.Hm().format(dateTime.toDate()).toString();
  List<String> nowSeparated = [date,time];
  String nowJoined = nowSeparated.join(' at ');
  return nowJoined;
}
String time = DateTime.now().toString().split(' ').elementAt(1);