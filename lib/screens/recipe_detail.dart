import 'package:flutter/material.dart';
import 'package:platzi/models/ricipe_model.dart';
import 'package:platzi/providers/ricipes_provider.dart';
import 'package:provider/provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipesDarta;
  const RecipeDetail({
      super.key,
      required this.recipesDarta
    });

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  bool isFavorite = false;
  @override
  void didCahngeDeoendencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false).favoriterRecipe.contains(widget.recipesDarta);
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipesDarta.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () async {
              await Provider.of<RecipesProvider>(context, listen: false).toggleFavoriteStatus(widget.recipesDarta);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
    );
  }
}