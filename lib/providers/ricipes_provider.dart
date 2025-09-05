import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platzi/models/ricipe_model.dart';
import 'package:http/http.dart' as http;

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];
  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners();

    // Android 10.0.2.2
    final url = Uri.parse('http://10.0.2.2:3001/recipes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        recipes = List<Recipe>.from(data['recipes'].map((item) => Recipe.fromJson(item)));
      } else{
        print('Error fetching recipes: ${response.statusCode}');
        recipes = [];
      }
    } catch (e) {
      print('Error fetching recipes: $e');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}