import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function fun) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
      ),
      onTap: fun,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Theme.of(context).accentColor,
            alignment: Alignment.center,
            height: 120,
            width: double.infinity,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.red[400]),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile("Meal", Icons.restaurant_menu, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile("Filter", Icons.filter_list_alt, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
        ],
      ),
    );
  }
}
