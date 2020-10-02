import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/CustomWidgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/size_config.dart';

class MyFavorites extends StatefulWidget {
  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child("eventPicture/image_picker603815392078609585.jpg");
    
    String url = await storageReference.getDownloadURL();
    print("this is download url : " + url);


  }

  @override
  Widget build(BuildContext context) {
    uploadFile();
    return CustomScaffoldWithNavBar(
        Container(
            child: SingleChildScrollView(
              child: Column(children: [
                FavoriteCardView(),
                FavoriteCardView(),
                FavoriteCardView(),

              ],
              ),
            )
        ),
      title: "Favorites",
      extendBody: false,
    );
  }
}


class FavoriteCardView extends StatefulWidget {
  @override
  _FavoriteCardViewState createState() => _FavoriteCardViewState();
}

class _FavoriteCardViewState extends State<FavoriteCardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(229, 229, 229, 1),
      child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    AssetImage('images/flower2.jpg'),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Søndags is',
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'med Futte, 23',
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Favorit!");
                            },
                            child: Icon(Icons.favorite,
                              color: Colors.grey, size: 30,),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              print("Favorit!");
                            },
                            child: Icon(Icons.ios_share,
                              color: Colors.grey, size: 30,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
           Container(
             color: Colors.transparent,
             child: Center(
               child: AspectRatio(
                 aspectRatio: 204.5/100,
                 child: Container(
                   height: SizeConfig.blockSizeVertical*25,
                   decoration: new BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.all(Radius.circular(15)),
                       image: new DecorationImage(
                         fit: BoxFit.fitWidth,
                         alignment: FractionalOffset.centerLeft,
                         image: AssetImage("images/ice.png"),
                          ),
                       )
                   ),
               ),
             ),
             )
          ],
        ),
      ),
    ),);
  }
}
