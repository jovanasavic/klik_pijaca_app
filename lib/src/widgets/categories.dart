import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/models/category.dart';
import 'package:klik_pijaca_app/src/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

import 'custom_text.dart';

class Category extends StatelessWidget {
  final CategoryModel category;

  const Category({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
              width: 80,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      ),
                    ),
                    Center(
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: category.image),
                    )
                  ],
                ),
              )),
          Container(
            width: 80,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          // Positioned.fill(
          //     child: Align(
          //         alignment: Alignment.center,
          //         child: CustomText(
          //           text: category.name,
          //           color: white,
          //           size: 26,
          //           weight: FontWeight.w300,
          //         )))
        ],
      ),
    );
  }
}
