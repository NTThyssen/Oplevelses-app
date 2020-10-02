import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(80),
        title: Text('Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image with gradient
            Stack(
              children: [
                Image(
                  fit: BoxFit.cover,
                  image: AssetImage('images/pia-profile-pic.jpg'),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 1.471,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.5, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Theme.of(context).primaryColor,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Event header
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Søndags-is med Pia, 22',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
            // Place info
            Row(
              children: [
                Icon(
                  Icons.place,
                  color: Colors.white,
                ),
                Text(
                  'København NV',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
            // Date info
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                Text(
                  'Lørdag 4. jul Kl. 10.00',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
            // Price info
            Row(
              children: [
                Icon(
                  Icons.payment,
                  color: Colors.white,
                ),
                Text(
                  'Gratis',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
            Text(
              'Oplevelsen',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Info tekst - om oplevelsen \n At flyve helikopter er en helt speciel fornemmelse. Lyden af propellen blandet med den betagende panorama udsigt...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
