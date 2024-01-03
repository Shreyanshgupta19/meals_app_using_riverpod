import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  const MealDetailsScreen({super.key, required this.meal,});

  final Meal meal;


  @override
  ConsumerState<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen> {

  @override
  Widget build(BuildContext context) {// Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(widget.meal);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              backgroundColor: Colors.transparent,
              clipBehavior: Clip.hardEdge,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              pinned: true,
              centerTitle: false,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.transparent, Colors.black26],
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          child: Hero(
                            tag: widget.meal.id,
                            child: Image.network(
                              widget.meal.imageUrl,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 250,
                        left: 100,
                        right: 0,
                        top: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                            ),
                            child: Container(
                              width: double.infinity,
                              color: Colors.black54,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: Text(
                                    widget.meal.title,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16.6,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 250,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(0),
                          ),
                          child: Container(
                            width: double.infinity,
                            color: Colors.black54,
                            child: Center(

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Tooltip(
                                        message: 'Add to Favorites',
                                        showDuration: const Duration(seconds: 2),
                                        decoration: BoxDecoration(color: Colors.grey),
                                        textAlign: TextAlign.center,
                                        child: IconButton(
                                            onPressed: (){
                                            final wasAdded = ref.read(favoriteMealsProvider.notifier).toggleMealsFavoriteStatus(widget.meal);
                                             ScaffoldMessenger.of(context).clearSnackBars();
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               SnackBar(
                                                 duration: const Duration(seconds: 2),
                                                 content: Text(wasAdded ? 'Meal added as a favorite.' : 'Meal removed.'),
                                               ),
                                             );

                                            },
                                            icon: AnimatedSwitcher(
                                              duration: const Duration(milliseconds: 300),
                                            transitionBuilder: (child, animation) {
                                                return RotationTransition(
                                                  turns: Tween<double>(begin: 0.8, end: 1.0,).animate(animation),// animation,
                                                  child: child,
                                                );
                                            },
                                            child: Icon(isFavorite ? Icons.star : Icons.star_border, color: Colors.white, key: ValueKey(isFavorite),),
                                            ),
                                        ),
                                    ),


                                  ],
                                ),

                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Center(
                        child: Text(
                          'Ingredients :',
                          style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 20),
                          // style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          //   color: Theme.of(context).colorScheme.primary,
                          // ),
                        ),
                      ),
                    );
                  }
                  final ingredient = widget.meal.ingredients[index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(ingredient,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  );
                },
                childCount: widget.meal.ingredients.length + 1,
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Center(
                        child: Text(
                          'Steps :',
                          style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 20),
                          // style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          //   color: Theme.of(context).colorScheme.primary,
                          // ),
                        ),
                      ),
                    );
                  }
                  final step = widget.meal.steps[index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(step,
                    //  style: TextStyle(color: Colors.white,fontSize: 15),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  );
                },
                childCount: widget.meal.steps.length + 1,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
