import 'package:flutter/material.dart';
import 'event_details.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => MyApp(),
      '/event_details': (context) => Test(),
    },
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
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/event_details');
        },
        child: Stack(
          children: [PageView(
            children: [Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: AssetImage('images/flower2.jpg'),
                          ),
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
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
                          ),
                          Expanded(
                            flex: 3,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("sharing!");
                                    },
                                    child: Icon(
                                      Icons.share_sharp,
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  GestureDetector(
                                    onTap: () {
                                      print("Favorit!");
                                    },
                                    child: Icon(
                                      Icons.favorite_border
                                    ),
                                  )
                                ],
                              ),

                              ),
                        ],

                      ),
                    ),
                  ),
                  Expanded(
                      flex: 10,
                      child: Container(
                        child: Text("we"),
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
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/sexy.jpg"),
                ),
              ),

       ) ],
          ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: Icon(Icons.wine_bar),
                      backgroundColor: Colors.lightBlue[300],
                    ),
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: () {
                        print("Size W is ${MediaQuery.of(context).size.width}");
                        print("Size H is ${MediaQuery.of(context).size.height}");
                        // Add your onPressed code here!
                      },
                      child: Icon(Icons.add_circle_outlined),
                      backgroundColor: Colors.lightBlue[300],
                    ),
                    FloatingActionButton(
                      heroTag: "btn3",
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: Icon(Icons.account_circle),
                      backgroundColor: Colors.lightBlue[300],
                    ),
                  ],
                ),
              )],
            ),

            ]
        ),

      ),

    );
  }
}


