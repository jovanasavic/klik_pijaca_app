import 'package:klik_pijaca_app/src/helpers/screen_navigation.dart';
import 'package:klik_pijaca_app/src/providers/product.dart';
import 'package:klik_pijaca_app/src/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helpers/style.dart';
import 'custom_text.dart';
import 'loading.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 260,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (_, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
                child: GestureDetector(
                  onTap: () {
                    changeScreen(
                        _,
                        Details(
                          product: productProvider.products[index],
                        ));
                  },
                  child: Container(
                    height: 220,
                    width: 200,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                productProvider.products[index].name,
                                style: TextStyle(
                                        fontFamily: 'Sketch_Block',
                                        fontSize: 16,
                                        color: Color.fromRGBO(0, 86, 45, 1)) ??
                                    "id null",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IconButton(
                                icon: new Image.asset('images/like2.png'),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Loading(),
                              )),
                              Center(
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: productProvider.products[index].image,
                                  height: 126,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: white,
                                    boxShadow: [
                                      // BoxShadow(
                                      //     //color: Colors.grey[300],
                                      //     offset: Offset(1, 1),
                                      //     blurRadius: 4),
                                    ]),
                              ),
                            )
                          ],
                        ),
                        Container(
                          color: Color.fromRGBO(0, 86, 45, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 8.0),
                                  //   child: CustomText(
                                  //     text: productProvider.products[index].rating
                                  //         .toString(),
                                  //     color: grey,
                                  //     size: 14.0,
                                  //   ),
                                  // ),
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
                                    color: white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 86, 45, 1),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: []),
                          //  color: Colors.redAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                    "RSD" +
                                        productProvider.products[index].price
                                            .toString(),
                                    style: TextStyle(
                                        fontFamily: 'Sketch_Block',
                                        fontSize: 22,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
