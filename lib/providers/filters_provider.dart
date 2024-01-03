import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/filters.dart';

enum Filter {
  gultenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(
      {
    Filter.gultenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
    }
  );

  void setFilters(Map<Filter, bool> chosenFilters) {  // here this map is called chosenFilters
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;  // Not allowed! => mutating state
    state = {
      ...state,
      filter : isActive,
    };
  }

}

final filtersProvider = StateNotifierProvider< FiltersNotifier, Map<Filter, bool> >(
      (ref) => FiltersNotifier(),
);
