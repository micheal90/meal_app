import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/meal_items.dart';
import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeal=Provider.of<MealProvider>(context).favoriteMeals;

    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text(
          "You have not favorites yet - start adding some",
          style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,
        ),
      );
    } else
      return ListView.builder(
        itemCount: favoriteMeal.length,
        itemBuilder: (context, index) {
          return MealItems(
            id: favoriteMeal[index].id,
            imageUrl: favoriteMeal[index].imageUrl,
            title: favoriteMeal[index].title,
            affordability: favoriteMeal[index].affordability,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
          );
        },
      );
  }
}
