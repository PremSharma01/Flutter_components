import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {

  String location; // location name for the UI
  String time; // the time in that location
  String flag; // url to an assent flag icon
  String url; // location url for api endpoint
  bool isDaytime; // if day then true else false

  WorldTime({ this.location, this.flag , this.url});

  Future<void> getTime() async {
    try {
          // make the request
          Response response = await get(
              'http://worldtimeapi.org/api/timezone/$url');
          Map data = jsonDecode(response.body);
          // print(data);

          // get properties from data
          String datetime = data['datetime'];
          String offset = data['utc_offset'].substring(1, 3);
          String offsetmin = data['utc_offset'].substring(4);
          // print(datetime);
          //print(offset);

          // create DateTime object
          DateTime now = DateTime.parse(datetime);
          now = now.add(Duration(hours: int.parse(offset),minutes: int.parse(offsetmin)));

          // set the time property
          isDaytime = now.hour >4 && now.hour <20?true:false;
          time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('error: $e');
      time= 'could not get time and date';
    }
  }

}