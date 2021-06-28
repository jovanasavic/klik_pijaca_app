import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/helpers/screen_navigation.dart';
import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/models/category.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/product.dart';
import 'package:klik_pijaca_app/src/screens/product_search.dart';
import 'package:klik_pijaca_app/src/widgets/product.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'details.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryScreen({Key key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[],
          ),
          ListTile(
            leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.green[900],
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (pattern) async {
                app.changeLoadingState();
                await productProvider.search(productName: pattern);
                changeScreen(context, ProductSearchScreen());
                app.changeLoadingState();
              },
              decoration: InputDecoration(
                hintText: ("Pretraži..."),
                border: InputBorder.none,
              ),
            ),
            trailing: Icon(Icons.search, color: Colors.green[900]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 2.0),
            child: FadeInImage.memoryNetwork(
                height: 60,
                placeholder: kTransparentImage,
                image: categoryModel.imageCover),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: productProvider.productsByCategory
                .map((item) => GestureDetector(
                      onTap: () {
                        changeScreen(context, Details(product: item));
                      },
                      child: ProductWidget(
                        product: item,
                      ),
                    ))
                .toList(),
          )
        ],
      )),
    );
  }
}
