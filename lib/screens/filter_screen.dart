import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/tab_screen.dart';
import 'package:meal_app/widgets/Main_Drawer.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';
final bool onBoarding;

   FilterScreen({this.onBoarding=false});


  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {

    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show("exit_warning", context,duration:Toast.LENGTH_LONG);
      return Future.value(false);
    }
    return Future.value(true);
  }


  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        value: currentValue,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          description,
        ),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()=>Navigator.of(context).pushNamed(TabScreen.routeName),
      child: Scaffold(
        appBar:widget.onBoarding?AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,): AppBar(
          title: Text("Your Filters"),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: ()=> Provider.of<MealProvider>(context,listen: false).setFilters()
            )
          ],

        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  "Gluten Free",
                  "only include gluten free meals.",
                  Provider.of<MealProvider>(context,listen: false).filters['gluten'],
                  (newValue) {
                    setState(() {
                      Provider.of<MealProvider>(context,listen: false).filters['gluten'] = newValue;
                    });

                  },
                ),
                buildSwitchListTile(
                  "lactose Free",
                  "only include lactoseFree free meals.",
                  Provider.of<MealProvider>(context,listen: false).filters['lactose'],
                  (newValue) {
                    setState(() {
                      Provider.of<MealProvider>(context,listen: false).filters['lactose'] = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  "Vegan",
                  "only include vegan free meals.",
                  Provider.of<MealProvider>(context,listen: false).filters['vegan'],
                  (newValue) {
                    setState(() {
                      Provider.of<MealProvider>(context,listen: false).filters['vegan'] = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  "Vegetarian Free",
                  "only include vegetarian free meals.",
                  Provider.of<MealProvider>(context,listen: false).filters['vegetarian'],
                  (newValue) {
                    setState(() {
                      Provider.of<MealProvider>(context,listen: false).filters['vegetarian'] = newValue;
                    });
                  },
                )
              ],
            ),
          )
        ]),
        drawer:widget.onBoarding?null: MainDrawer(),
      ),
    );
  }
}
