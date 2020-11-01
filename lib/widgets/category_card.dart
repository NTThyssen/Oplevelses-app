import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/enums.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatefulWidget {
  CategoryCard({
    Key key,
    this.image,
    this.text,
    this.onTap,
    this.state,
  }) : super(key: key);

  final String image;
  final String text;
  final VoidCallback onTap;

  final ActivityState state;

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
          color: widget.state == ActivityState.Selected ? blue : Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
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
        onTap: widget.onTap,
      ),
    );
  }
}
