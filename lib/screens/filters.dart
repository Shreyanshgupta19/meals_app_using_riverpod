import 'package:flutter/material.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class FiltersScreen extends ConsumerWidget {
  const FiltersScreen ({super.key });



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters!'),
      ),


      body:  Column(
          children: [
            SwitchListTile(   // on/off button
              value: activeFilters[Filter.gultenFree]!,  // here, value: accepts a bool value  // here, _glutenFreeFilterSet is a bool and containing _FiltersScreenState class
              onChanged: (isChecked){  // here, isChecked is bool  // onChanged, accepts a void Function(bool)? onChanged  //  initially the value of _glutenFreeFilterSet is false when we clicked onChanged and the value of isChecked is opposite of value of _glutenFreeFilterSet  and in this function we changed the value of _glutenFreeFilterSet
               ref.read(filtersProvider.notifier).setFilter(Filter.gultenFree, isChecked);
              },
              title: Text('Gluten-free',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
              ),
              subtitle: Text('Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22,),
            ),


            SwitchListTile(
              value: activeFilters[Filter.lactoseFree]!,
              onChanged: (isChecked){  // here, isChecked is bool
                ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, isChecked);
              },
              title: Text('Lactose-free',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
              ),
              subtitle: Text('Only include Lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22,),
            ),


            SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (isChecked){  // here, isChecked is bool
                ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, isChecked);
              },
              title: Text('Vegetarian',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
              ),
              subtitle: Text('Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22,),
            ),


            SwitchListTile(
              value: activeFilters[Filter.vegan]!,
              onChanged: (isChecked){  // here, isChecked is bool
                ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isChecked);
              },
              title: Text('Vegan',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
              ),
              subtitle: Text('Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22,),
            ),
          ],
        ),
    );
  }
}