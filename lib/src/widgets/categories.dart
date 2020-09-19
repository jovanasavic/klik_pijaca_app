import 'package:klik_pijaca_app/src/models/category.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

List<CategoryModel> categoriesList = [];
class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context,index){
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget> [
                Container(

                    child: Padding(padding: EdgeInsets.all(4),
                      child: Image.asset("images/${categoriesList[index].image}", width: 60,),)
                ),
                SizedBox(height: 5,),
                CustomText(text: categoriesList[index].name, size: 16,)

              ],
            ),
          );
        },

      ),
    );
  }
}
