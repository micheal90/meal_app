import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static final String routeName = "/MealDetailScreen";
  List favoriteMeals;
  bool isTrue;

  Widget BuildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget BuildContainer(Widget child, BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 3),
            borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: isLandscape ? (dh * 0.5) : (dh * 0.25),
        width: isLandscape ? (dw * 0.5 - 20) : dw,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final String _mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == _mealId);
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(selectedMeal.title,style: TextStyle(backgroundColor: Colors.black54),),
              background: Hero(
                tag: _mealId,
                child: InteractiveViewer(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/wait-image.png'),
                    image: NetworkImage(
                      selectedMeal.imageUrl,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: [
                if (isLandscape)
                  Row(
                    children: [
                      Column(
                        children: [
                          BuildSectionTitle(context, "Ingredients"),
                          BuildContainer(
                              ListView.builder(
                                itemBuilder: (context, index) => Card(
                                  color: Theme.of(context).accentColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      selectedMeal.ingredients[index],
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                                itemCount: selectedMeal.ingredients.length,
                              ),
                              context),
                        ],
                      ),
                      Column(
                        children: [
                          BuildSectionTitle(context, "Steps"),
                          BuildContainer(
                              ListView.builder(
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Text("${index + 1}"),
                                      ),
                                      title: Text(selectedMeal.steps[index]),
                                    ),
                                    Divider()
                                  ],
                                ),
                                itemCount: selectedMeal.steps.length,
                              ),
                              context)
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                if (!isLandscape) BuildSectionTitle(context, "Ingredients"),
                if (!isLandscape)
                  BuildContainer(
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) => Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              selectedMeal.ingredients[index],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        itemCount: selectedMeal.ingredients.length,
                      ),
                      context),
                if (!isLandscape) BuildSectionTitle(context, "Steps"),
                if (!isLandscape)
                  BuildContainer(
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(
                                selectedMeal.steps[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Divider()
                          ],
                        ),
                        itemCount: selectedMeal.steps.length,
                      ),
                      context),
              ],
            )
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Provider.of<MealProvider>(
            context,
          ).isMealFavorite(_mealId)
              ? Icons.star
              : Icons.star_border),
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(_mealId)),
    );
  }
}
