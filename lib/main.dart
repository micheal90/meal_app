import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/filter_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tab_screen.dart';

void main() async {
  Widget mainScreen;
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  //pref.clear();
  mainScreen =
      pref.getBool('watch') ?? false ? TabScreen() : OnBoardingScreen();
  print("watch get:${pref.getBool('watch')}");
  runApp(ChangeNotifierProvider<MealProvider>(
    create: (context) => MealProvider(),
    child: MyApp(mainScreen),
  ));
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;

  MyApp(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Meals',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.orangeAccent,
          canvasColor: Color.fromRGBO(255, 254, 230, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
                bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 50, 50, 1), fontSize: 20),
              )),
      darkTheme: ThemeData(),
      //home: CategoryScreen(),
      routes: {
        "/": (context) => mainScreen,
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen(),
        TabScreen.routeName: (context) => TabScreen()
      },
    );
  }
}
