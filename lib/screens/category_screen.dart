import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/category_items.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(20),
        children: Provider.of<MealProvider>(context)
            .availableCategory
            .map((catData) => CategoryItems(
                  id: catData.id,
                  title: catData.title,
                  color: catData.color,
                  imageUrl: catData.imageUlr,
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw < 300 ? 300 : 400,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
      ),
    );
  }
}
