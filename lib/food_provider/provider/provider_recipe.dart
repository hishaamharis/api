// provider/recipeProvider.dart
import 'package:flutter/cupertino.dart';

import '../model/model_recipe.dart';
import '../service/service_recipe.dart';


class RecipeProvider extends ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];

  List<Recipe> get recipes => _filteredRecipes.isNotEmpty ? _filteredRecipes : _recipes;

  Future<void> fetchRecipes() async {
    try {
      Recepie recepie = await RecipeService().fetchRecipes();
      _recipes = recepie.recipes ?? [];
      _filteredRecipes = _recipes; // Initialize filtered recipes with all recipes
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  void searchRecipes(String query) {
    _filteredRecipes = _recipes.where((recipe) {
      return recipe.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}