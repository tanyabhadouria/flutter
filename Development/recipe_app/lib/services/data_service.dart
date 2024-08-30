import 'dart:io';

import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService
      ._internal(); //his creates a singleton instance of DataService.
  //This means only one instance of this class can exist throughout the application.

  final HTTPService _httpService =
      HTTPService(); //This creates an instance of the HTTPService class for making HTTP requests.
  factory DataService() {
    //This is a factory constructor. It returns the singleton instance (_singleton) instead of creating a new object when called.
    return _singleton;
  }
  DataService._internal(); //This is a private constructor that prevents creating new instances directly. Only the factory constructor can access it.
  Future<List<Recipe>?> getRecipe(String filter) async {
    String path = "recipe/";
    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();

      return recipes;
    }
  }
}

//This is an asynchronous method called getRecipe that takes a filter (presumably a recipe category or similar) as a string argument and returns a Future<List<Recipe>?>. It performs the following steps:
// Defines a base path for recipe data ("recipe/").
// If a filter is provided, it adds the filter string to the path (e.g., "recipe/meal-type/italian").
// Uses _httpService.get to send a GET request to the constructed path.
// Checks the response status code. If it's 200 (success) and there's data, it extracts the "recipes" list from the response data.
// Uses map function to iterate over each recipe in the list and convert them to Recipe objects using Recipe.fromJson (presumably a method in the Recipe class to convert JSON data to a Recipe object).
// Returns the list of converted Recipe objects.
// Returns null in case of failures (e.g., non-200 status code or missing data).
// Overall, this class retrieves recipe data from the server based on an optional filter and parses the response to create a list of Recipe objects.
