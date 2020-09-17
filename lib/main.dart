import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('images/flower2.jpg'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nicklas 23',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                          Text(
                            'aktivitet 5km væk',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w300,
                                fontSize: 16
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],

                ),
              ),
            ),
            Expanded(
                flex: 10,
                child: Center(child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Draggable(
                        axis: Axis.vertical,
                        feedback: Drag(),
                        child: Drag()

                    ),
                
                  ),
                ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: Icon(Icons.wine_bar),
                      backgroundColor: Colors.lightBlue[300],
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        print("Size W is ${MediaQuery.of(context).size.width}");
                        print("Size H is ${MediaQuery.of(context).size.height}");
                        // Add your onPressed code here!
                      },
                      child: Icon(Icons.add_circle_outlined),
                      backgroundColor: Colors.lightBlue[300],
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: Icon(Icons.account_circle),
                      backgroundColor: Colors.lightBlue[300],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("images/flower.jpg"),
        ),
      ),
    ),
        
    );
  }
}

class Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  double top = 0;
  double left = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Draggable(
          child: Container(
            padding: EdgeInsets.only(top: top, left: left),
            child: DragItem(),
          ),
          feedback: Container(
            padding: EdgeInsets.only(top: top, left: left),
            child: DragItem(),
          ),
          childWhenDragging: Container(
            padding: EdgeInsets.only(top: top, left: left),
            child: DragItem(),
          ),
          onDragCompleted: () {},
          onDragEnd: (drag) {
            setState(() {
              top = top + drag.offset.dy < 0 ? 0 : top + drag.offset.dy;
              left = left + drag.offset.dx < 0 ? 0 : left + drag.offset.dx;
            });
          },
        ),
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(57744, fontFamily: 'MaterialIcons'),
      size: 36,
    );
  }
}