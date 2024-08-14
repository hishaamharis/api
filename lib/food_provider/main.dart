
import 'package:api2/food_provider/provider/provider_recipe.dart';
import 'package:api2/food_provider/screens/home.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()..fetchRecipes()),
      ],
      child: MaterialApp(
        title: 'Recipe App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RecipeListPage(),
      ),
    );
  }
}