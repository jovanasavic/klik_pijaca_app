import 'package:klik_pijaca_app/src/helpers/screen_navigation.dart';
import 'package:klik_pijaca_app/src/models/products.dart';
import 'package:klik_pijaca_app/src/screens/details.dart';
import 'package:flutter/material.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

List<ProductModel> productsList = [];

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: GestureDetector(
                onTap: (){
                  changeScreen(context, Details(product: productsList[index]));
                },
                child: Container(
                  height: 220,
                  width: 200,
                  decoration: BoxDecoration(color: white, boxShadow: [
                    BoxShadow(
                        color: green, offset: Offset(1, 1), blurRadius: 4)
                  ]),
                  child: Column(
                    children: <Widget>[
                      Image.asset("images/${productsList[index].image}", height: 140),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(text: productsList[index].name),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: grey,
                                        offset: Offset(1, 1),
                                        blurRadius: 4)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:
//                                productsList[index].wishList ?
                                Icon(
                                  Icons.favorite,
                                  size: 18,
                                  color: Colors.red,
                                )
//                                    :  Icon(
//                                  Icons.favorite_border,
//                                  size: 18,
//                                  color: Colors.red,
//                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(
                                    text: productsList[index].rating.toString(), color: grey, size: 14),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: CustomText(text: "RSD" + productsList[index].price.toString()),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

