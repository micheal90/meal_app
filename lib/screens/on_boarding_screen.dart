import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/tab_screen.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onBoardingScreen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageIndicatorContainer(
          length: 2,
          shape: IndicatorShape.circle(size: 20),
          child: PageView(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('assets/images/image2.jpg'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Welcome To",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.black54),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Cooking Up!",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.black54),
                    ),
                    //SizedBox(height: 2,)
                  ],
                ),
              ),
              FilterScreen(
                onBoarding: true,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, 0.8),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black54),
              onPressed: () async {
                Provider.of<MealProvider>(context, listen: false).setFilters();
                Navigator.of(context).pushReplacementNamed(TabScreen.routeName);

                var pref = await SharedPreferences.getInstance();
                pref.setBool('watch', true);
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: "Raleway",
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
