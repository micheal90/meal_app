import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

import '../models/category.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false
  };
  bool isWatchedOnBoardingScreen=false;
  List<Meal> favoriteMeals = [];
  List<Meal> availableMeal = DUMMY_MEALS;
  List<String> sharedMealId = [];
  List<Category> availableCategory = DUMMY_CATEGORIES;

  void setFilters() async {
    availableMeal = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) return false;
      if (filters['lactose'] && !meal.isLactoseFree) return false;
      if (filters['vegan'] && !meal.isVegan) return false;
      if (filters['vegetarian'] && !meal.isVegetarian) return false;
      return true;
    }).toList();
    print(availableMeal.length);
    List<Category> ac = [];
    availableMeal.forEach((meal) {
      meal.categories.forEach((catMealId) {
        DUMMY_CATEGORIES.forEach((catId) {
          if ((catId.id == catMealId)) {
            if (!ac.any((element) => element.id == catMealId)) ac.add(catId);
          }
        });
      });
    });
    //this code meaning is: remove the categories don't have any meal after set filters
    availableCategory = ac;
    print("ac is $ac");
    notifyListeners();

    var pref = await SharedPreferences.getInstance();
    pref.setBool('gluten', filters['gluten']);
    pref.setBool('lactose', filters['lactose']);
    pref.setBool('vegan', filters['vegan']);
    pref.setBool('vegetarian', filters['vegetarian']);
  }

  void getSharedData() async {
    var pref = await SharedPreferences.getInstance();
    //pref.clear();
    //get filters from sharedPreferences
    filters['gluten'] = pref.getBool('gluten') ?? false;
    filters['lactose'] = pref.getBool('lactose') ?? false;
    filters['vegan'] = pref.getBool('vegan') ?? false;
    filters['vegetarian'] = pref.getBool('vegetarian') ?? false;
    print("shared val:${pref.getBool('gluten')}");
    print("filters val: ${filters['gluten']}");

    //get favoriteMeals from sharedPreferences
    List<String> mealSharedFavorite = pref.getStringList('sharedMealId') ?? [];
    print(pref.getStringList('sharedMealId'));

    print("getSharedData: $mealSharedFavorite");
    for (var mealId in mealSharedFavorite) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      //if existingIndex not found in favoriteMeals add it else nothing
      if (existingIndex < 0) {
        //meaning is the meal not found in favoriteMeals add it
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        sharedMealId.add(mealId);
      }
    }
    notifyListeners();
    setFilters();
    //print("sharedmeal : $sharedMealId");
    //this code meaning: remove meals from favoriteMeal if set filters
    List<Meal> fm = [];
    favoriteMeals.forEach((favMeal) {
      availableMeal.forEach((avMeal) {
        if (favMeal.id == avMeal.id) fm.add(favMeal);
      });
    });
    favoriteMeals = fm;


  }

  void toggleFavorite(String mealId) async {
    var pref = await SharedPreferences.getInstance();
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      sharedMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      sharedMealId.add(mealId);
    }
    pref.setStringList('sharedMealId', sharedMealId);
    print("setSharedData: $sharedMealId");
    notifyListeners();
  }

  bool isMealFavorite(String id) {
    return (favoriteMeals.any((meal) => meal.id == id));
  }
}
