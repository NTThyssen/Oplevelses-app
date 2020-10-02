import 'package:flutter/material.dart';
import 'package:flutter_app/CustomWidgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/size_config.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithNavBar(
        Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical*8,),
                Container(
                  width: SizeConfig.blockSizeHorizontal*40,
                  height: SizeConfig.blockSizeVertical*25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Theme.of(context).secondaryHeaderColor
                  ),
                  child: IconButton(
                    onPressed: (){

                    },
                    icon: Icon(Icons.add, size: 50, color: Colors.white,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tilføj billede"),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*3,),
                InoutBoxWithBottomShadow("Overskrift"),
                InoutBoxWithBottomShadow("Beskrivelse", bigBox: true,),
                InoutBoxWithBottomShadow("Pris"),
                InoutBoxWithBottomShadow("Dato"),
                InoutBoxWithBottomShadow("By"),
              ],
            ),
          ),

    )
    );
  }
}


class InoutBoxWithBottomShadow extends StatefulWidget {
  final String hintText;
  final bool bigBox;
  InoutBoxWithBottomShadow(this.hintText, {this.bigBox});

  @override
  _InoutBoxWithBottomShadowState createState() => _InoutBoxWithBottomShadowState();
}

class _InoutBoxWithBottomShadowState extends State<InoutBoxWithBottomShadow> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 180,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    labelText: widget.hintText,
                    counterText: "",
                ),

              ),
            ),
            width: SizeConfig.blockSizeHorizontal*90,
            height: widget.bigBox == null ? SizeConfig.blockSizeHorizontal*14 : SizeConfig.blockSizeHorizontal*35,
            margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
