import 'package:http/http.dart' as http;

import '../model/model_recipe.dart';




class RecipeService {
  static const String _baseUrl = 'https://dummyjson.com/recipes';

  Future<Recepie> fetchRecipes() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return recepieFromJson(response.body);
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}