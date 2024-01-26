import "package:buytime/gigs.dart";

class SearchManager {
  List<Location> allItems = locations;
  List<Location> displayedItems = [];
  bool isSearchOpen = false;


  SearchManager() {
    displayedItems = List.from(allItems);
  }

  void searchItems(String query) {
    List<Location> results = [];
    if (query.isEmpty) {
      results = List.from(allItems);
    } else {
      results = allItems.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();

      results.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }

    displayedItems = results;
  }
}