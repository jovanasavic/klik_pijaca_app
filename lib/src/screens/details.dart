import 'package:klik_pijaca_app/src/helpers/screen_navigation.dart';
import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/models/products.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/user.dart';
import 'package:klik_pijaca_app/src/screens/cart.dart';
import 'package:klik_pijaca_app/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/widgets/loading.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;
  Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _key = GlobalKey<ScaffoldState>();

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: SafeArea(
        child: app.isLoading
            ? Loading()
            : Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.product.image),
                              radius: 150),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: black,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.add_shopping_cart,
                                                color: black, size: 35),
                                            onPressed: () {
                                              changeScreen(
                                                  context, CartScreen());
                                            }),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 2,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: grey,
                                                  offset: Offset(2, 3),
                                                  blurRadius: 3)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: CustomText(
                                            text: userProvider
                                                .userModel.cart.length
                                                .toString(),
                                            color: green,
                                            size: 18,
                                            weight: FontWeight.bold,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            right: 20,
                            bottom: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: grey,
                                        offset: Offset(2, 1),
                                        blurRadius: 3)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.favorite,
                                  size: 22,
                                  color: black,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  CustomText(
                    text: widget.product.name,
                    size: 26,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "RSD" + widget.product.price.toString(),
                    size: 18,
                    weight: FontWeight.w400,
                    color: green,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 36,
                            ),
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            }),
                      ),
                      GestureDetector(
                        onTap: () async {
                          bool value = await userProvider.addToCard(
                              product: widget.product, quantity: quantity);

                          if (value) {
                            _key.currentState
                                .showSnackBar(SnackBar(content: Text("added")));
                            userProvider.reloadUserModel();
                            return;
                          } else {
                            _key.currentState.showSnackBar(
                                SnackBar(content: Text("not added")));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.red),
                          child: app.isLoading
                              ? Loading()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                  child: CustomText(
                                    text: "Add $quantity To Cart",
                                    color: white,
                                    size: 24,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 36,
                            ),
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            }),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
