import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/about_text.dart';
import 'package:flutter_app/widgets/friends_widget.dart';
import 'package:flutter_app/widgets/info_header_widget.dart';
import 'package:flutter_app/widgets/instagram_images_widget.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(80),
        title: Text('Søndags-is'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.share),
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
              padding: EdgeInsets.all(11),
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
                    CupertinoIcons.heart,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
            // Place info
            InfoHeaderWidget(
              icon: Icons.place,
              text: 'København NV',
            ),
            // Date info
            InfoHeaderWidget(
              icon: Icons.access_time,
              text: 'Lørdag 4. jul Kl. 10.00',
            ),
            // Price info
            InfoHeaderWidget(
              icon: Icons.payment,
              text: 'Gratis',
            ),
            // Event description
            AboutText(
              heading: 'Oplevelsen',
              body:
                  'Info tekst - om oplevelsen \n \"At flyve helikopter er en helt speciel fornemmelse. Lyden af propellen blandet med den betagende panorama udsigt...\"',
            ),
            // About event creator section
            AboutText(
              heading: 'Om Pia',
              body:
                  'Typen der altid løber efter bussen, og altid ender med at komme i alt for god tid.',
            ),
            // Common friends
            FriendsWidget(
              text: 'Fælles venner',
            ),
            // Instagram
            InstagramImagesWidget(),
            // Bottom icons
            Container(
              padding: EdgeInsets.only(bottom: 40.0, top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.repeat),
                    color: Theme.of(context).secondaryHeaderColor,
                    iconSize: 40.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.add_box),
                    color: Theme.of(context).secondaryHeaderColor,
                    iconSize: 40.0,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
