import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/screens/category_meal_screen.dart';

class CategoryItems extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final String imageUrl;

  const CategoryItems({this.id, this.title, this.color, this.imageUrl});

  void _selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealScreen.routeName,
        arguments: {"id": id, "title": title});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () => _selectCategory(context),
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 10,
            margin: EdgeInsets.all(2),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/wait-image.png'),
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.fill,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildContainer(context) {
    return Container(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: color,
          image:
              DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withOpacity(0.5)],
          )),
    );
  }
}
