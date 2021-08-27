import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../widgets/meal_items.dart';

class CategoryMealScreen extends StatefulWidget {
  static final routeName = "/CategoryMealScreen";

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;

  List<Meal> displayedMeal;

  @override
  void didChangeDependencies() {
    final List<Meal> _availableMeal =
        Provider.of<MealProvider>(context).availableMeal;
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg["id"];
    categoryTitle = routeArg["title"];
    displayedMeal = _availableMeal.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemCount: displayedMeal.length,
          itemBuilder: (context, index) {
            return MealItems(
              id: displayedMeal[index].id,
              imageUrl: displayedMeal[index].imageUrl,
              title: displayedMeal[index].title,
              affordability: displayedMeal[index].affordability,
              duration: displayedMeal[index].duration,
              complexity: displayedMeal[index].complexity,
            );
          },
        ));
  }
}
