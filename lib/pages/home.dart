import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.redAccent[100] : Colors.indigo[900];
    Color textcolor = data['isDaytime'] ? Colors.black: Colors.white;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      if(result != null){
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDaytime': result['isDaytime'],
                            'flag': result['flag']
                          };
                        });
                      }
                    },
                      icon:Icon(
                          Icons.edit_location_rounded,
                        color: textcolor,
                      ),
                      label: Text(
                          'Edit Location',
                        style: TextStyle(
                           color: textcolor
                        ),
                      ),
                  ),
                  SizedBox(height: 20.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['location'],
                            style: TextStyle(
                              fontSize: 28.0,
                              letterSpacing: 2.0,
                              color: textcolor
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          CircleAvatar(
                            backgroundImage: AssetImage('images/${data['flag']}'),
                            radius: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      Text(
                        data['time'],
                        style: TextStyle(
                            fontSize: 66.0,
                            color: textcolor
                        ),
                      ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
