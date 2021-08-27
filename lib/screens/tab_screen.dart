import 'package:flutter/material.dart';
import 'package:meal_app/main.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../screens/category_screen.dart';
import '../screens/favorite_Screen.dart';
import '../widgets/Main_Drawer.dart';
import 'category_screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/TabScreen';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  List<Map<String, Object>> pagesSelect;
  DateTime currentBackPressTime;
  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).getSharedData();
    main();
    pagesSelect = [
      {"page": CategoryScreen(), "title": "Categories"},
      {"page": FavoriteScreen(), "title": "Your Favorites"},
    ];
    super.initState();
  }

  void _selectedPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show("exit_warning", context, duration: Toast.LENGTH_LONG);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pagesSelect[_selectedPageIndex]["title"]),
        ),
        body: pagesSelect[_selectedPageIndex]["page"],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites")
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
