import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/user.dart';
import 'package:klik_pijaca_app/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/widgets/loading.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Shopping cart",
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(Icons.add_shopping_cart,
                            color: black, size: 30),
                        onPressed: () {})),
                Positioned(
                  right: 10,
                  bottom: 2,
                  child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: grey,
                                offset: Offset(2, 3),
                                blurRadius: 3)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: CustomText(
                          text: "2",
                          color: green,
                          size: 17,
                          weight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: userProvider.userModel.cart.length,
              itemBuilder: (_, index) {
                int totalQuantity = 0;
                int priceSum = 0;

                print("the price is" +
                    userProvider.userModel.cart[index]["price"].toString());
                print("the quantity is" +
                    userProvider.userModel.cart[index]["quantity"].toString());

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.green[50],
                              offset: Offset(3, 7),
                              blurRadius: 30)
                        ]),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          child: Image.network(
                            userProvider.userModel.cart[index]["image"],
                            height: 140,
                            width: 170,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: userProvider.userModel.cart[index]
                                          ["name"] +
                                      "\n",
                                  style: TextStyle(color: black, fontSize: 18)),
                              TextSpan(
                                  text: "RSD" +
                                      userProvider
                                          .userModel.cart[index]["price"]
                                          .toString() +
                                      "\n\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "quantity: ",
                                  style: TextStyle(color: grey, fontSize: 14)),
                              TextSpan(
                                  text: userProvider
                                          .userModel.cart[index]["quantity"]
                                          .toString() +
                                      "\n",
                                  style: TextStyle(color: grey, fontSize: 14)),
                            ])),
                            SizedBox(
                              width: 30,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: green,
                                ),
                                onPressed: () async {
                                  app.changeLoadingState();
                                  bool value =
                                      await userProvider.removeFromCart(
                                          cartItem: userProvider
                                              .userModel.cart[index]);
                                  if (value) {
                                    userProvider.reloadUserModel();
                                    _key.currentState.showSnackBar(
                                        SnackBar(content: Text("removed")));
                                    app.changeLoadingState();
                                    return;
                                  } else {
                                    _key.currentState.showSnackBar(
                                        SnackBar(content: Text("removed")));
                                    app.changeLoadingState();
                                  }
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Total: ",
                    style: TextStyle(color: grey, fontSize: 20)),
                TextSpan(
                    text: "RSD" +
                        userProvider.userModel.totalCartPrice.toString() +
                        "\n",
                    style: TextStyle(color: grey, fontSize: 20)),
              ])),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: green),
                child: FlatButton(
                  onPressed: () {},
                  child: CustomText(
                    text: "Pay now",
                    color: white,
                    weight: FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
