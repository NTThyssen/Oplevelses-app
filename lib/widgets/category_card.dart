import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatefulWidget {
  CategoryCard({this.image, this.text, this.selected});

  final String image;
  final String text;
  bool selected = false;

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        child: Card(
          color: widget.selected ? Colors.blue : Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            width: 111,
            height: 134,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: 60,
                    height: 60,
                    child: SvgPicture.asset(
                      widget.image,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            widget.selected = !widget.selected;
          });
        },
      ),
    );
  }
}
