import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(children: <Widget>[
        _RecioesCard(context),
        _RecioesCard(context),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to perform when the button is pressed
          _showBottom(context);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 640,
          color: Colors.white,
          child: Center(
            child: RecipeForm(),
          ),
        );
      },
    );
  }

  Widget _RecioesCard(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child:Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/lasagna.jpg',
                    fit: BoxFit.cover, 
                  )
                )                ,
              ),
              SizedBox(width: 26,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lasagna', 
                    style: TextStyle(
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      fontFamily: 'QuickSand')),
                  SizedBox(height: 5,),
                  Container(height: 2, width: 75, color: Colors.orange),
                  SizedBox(height: 5,),
                  Text('Carlos G', style: TextStyle(
                    fontFamily: 'QuickSand'
                  )),
                ]
              ),
            ],
          )
        )
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _recipeNameController = TextEditingController();
    final TextEditingController _recipeAuthorController = TextEditingController();
    final TextEditingController _recipeImageUrlController = TextEditingController();
    final TextEditingController _recipeController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add a new recipe', 
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24, 
              fontWeight: FontWeight.bold)),
            _buildTextField(
              controller: _recipeNameController, 
              label:'Recipe Name',
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe name';
                }
                return null;
              }
            ),
            _buildTextField(
              controller: _recipeAuthorController, 
              label:'Author',
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter the author\'s name';
                }
                return null;
              }
            ),
            _buildTextField(
              controller: _recipeImageUrlController, 
              label: 'Image Url',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              }
            ),
            _buildTextField(
              maxLines: 5,
              controller: _recipeController, 
              label:'Recipe',
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter the recipe details';
                }
                return null;
              }
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the data.
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit', style: TextStyle(fontFamily: 'Quicksand', color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            )
          ],
        )),
    );
  }
  Widget _buildTextField({
      required TextEditingController controller, 
      required String label,
      required String? Function(String?) validator,
      int maxLines = 1,
    }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.orange,
            fontFamily: 'Quicksand',
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }
}