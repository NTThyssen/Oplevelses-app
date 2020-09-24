import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/profile.dart';
import 'package:flutter_app/size_config.dart';

class MyOverview extends StatefulWidget {
  @override
  _MyOverviewState createState() => _MyOverviewState();
}

class _MyOverviewState extends State<MyOverview> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
        centerTitle: true,
        title: Container(
          width: SizeConfig.blockSizeHorizontal*40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = false;
                    });
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(9), topLeft: Radius.circular(9)),
                          border: Border.all(color: Colors.blue),
                          color: isFavorite == false ?  Colors.blue : Colors.transparent
                      ),
                      child: Icon(Icons.messenger_outline)),
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = true;
                    });
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(9), bottomRight: Radius.circular(9)),
                          border: Border.all(color: Colors.blue),
                          color: isFavorite == false ? Colors.transparent : Colors.blue
                      ),
                      child: Icon(Icons.favorite)),
                ),
              ),
            ],
          ),
        )
        ),
      body: Stack(
        children: [
          SingleChildScrollView(

          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                minWidth: SizeConfig.blockSizeHorizontal*100,
                height: SizeConfig.blockSizeVertical*9,
                elevation: 0,
                color: Colors.blue,
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventMainStep()),
                  );
                },
                child: Text("NYT OPSLAG", style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class EventMainStep extends StatefulWidget {
  @override
  _EventMainStepState createState() => _EventMainStepState();
}

class _EventMainStepState extends State<EventMainStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lav et opslag"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenuButton(text: "Pris", menuIcon: CupertinoIcons.tag_solid,),
          Divider(
            height: 1,
            thickness: 1.0,
            endIndent: 10.0,
            indent: 10,
          ),
          MenuButton(text: "Dato", menuIcon: Icons.date_range),
          Divider(
            height: 1,
            thickness: 1.0,
            endIndent: 10.0,
            indent: 10,
          ),
          MenuButton(text: "By", menuIcon: CupertinoIcons.location_solid,),
        ],
      ),
    );
  }
}

