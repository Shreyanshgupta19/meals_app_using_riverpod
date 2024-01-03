import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/favorites_provider.dart';

const kInitialFilters = {   // or Map<Filter, bool> kInitialFilters = {  key:value
  Filter.gultenFree: false,  // in map we don't assign values by '=' we assign only by using ':'
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};


class TabsScreen extends ConsumerStatefulWidget {    // In flutter_riverpod package we use in place of StatefulWidget = ConsumerStatefulWidget or StatelessWidget = ConsumerWidget
  const TabsScreen({super.key,});

  @override
  ConsumerState<TabsScreen> createState() {    // In flutter_riverpod package we use in place of State = ConsumerState
    return _TabsScreenState();
  }
}
class _TabsScreenState extends ConsumerState<TabsScreen>{
  int _selectedPageIndex = 0;  // initially in default, currentIndex = 0





  void _onTapselectPageIndex(int index){  // here index = selected index of items
    setState(() {
      _selectedPageIndex = index;  // it used to make clickable BottomNavigationBar
    });
  }

  void _setScreen(String identifier) async{
    Navigator.of(context).pop();
    if(identifier == 'filters'){  // pushReplacement is replace first screen of stack to second screen so therefore the back button wouldn't work because there is nowhere to go back to and second screen doesn't show default back button
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => FiltersScreen() ) );
     await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) => const FiltersScreen(), ) );    // Type of result : Map<Filter, bool>?  // here ? says that result variable is initially is null
    }
  }

  @override
  Widget build(BuildContext context){
    final meals = ref.watch(mealsProvider);     // .read() is used get data from our provider once or .watch() to set up a listener that will make sure that the build method executes again as our data changes and the official riverpod documentation recommends to use watch as often as possible even if you technically only need to read data once because this way, if you ever change your logic you can't run into unintended bugs where you forgot to replace a read with a watch That's why they recommend that you always use watch right from the start  // this 'ref' property in riverpod is just like as 'Widget' property
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where(
            (meal) {
      if(activeFilters[Filter.gultenFree]! && !meal.isGlutenFree){  // _selectedFilters[Filter.gultenFree]! = is not null,    !meal.isGlutenFree = is not true or exclude meals are not GlutenFree
        return false;  // if selected filter is gulten free and meal(dummymeal) is not gulten free then we return false that means we don't included this meal which has not satisfy both condition
      }
      if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(activeFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;   // if it satisfy all condition then we include this meal to a list form
          }
       ).toList();


    Widget activePage = CategoriesScreen( availableMeals: availableMeals,);  // default screen at _selectedPageIndex == 0
    var activePageTitle = 'Categories';    // default title at _selectedPageIndex == 0

    final favoriteMeals = ref.watch(favoriteMealsProvider);
    Widget favourite = Text(favoriteMeals.length.toString(),//Text(_favoriteMeals.length.toString(),
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
        color: Theme.of(context).cardColor,
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    );

    if(_selectedPageIndex == 1){
   //   final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals,);

      activePageTitle = 'Your Favorites';

      favourite = Text(favoriteMeals.length.toString(),//Text(_favoriteMeals.length.toString(),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 10,
          ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,  // currentIndex of items
        onTap: _onTapselectPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories',),  // items at index 0
          BottomNavigationBarItem(                     // items at index 1
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star,size: 18,),
                      // Positioned(
                       // bottom: 20,
                        // child:
                        favourite,
                         // ),
                        ],
                ),

            //  or
            // icon: Stack(
            //   children: [
            //     Container(
            //       width: double.maxFinite,
            //       child: Icon(Icons.favorite),
            //     ),
            //     Positioned(
            //       left: 115,
            //       bottom: 8,
            //       child: favourite,
            //     ),
            //   ],
            //
            // ),

            label: 'Favorites',),      // items at index 1
        ],
      ),
    );
  }
}
