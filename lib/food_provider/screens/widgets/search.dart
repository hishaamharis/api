import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/model_recipe.dart';

import '../../provider/provider_recipe.dart';


class RecipeSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // No results page needed
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final List<Recipe> suggestions = query.isEmpty
        ? []
        : recipeProvider.recipes.where((recipe) {
      return recipe.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].name ?? ''),
          onTap: () {
            close(context, suggestions[index].name ?? '');
          },
        );
      },
    );
  }
}