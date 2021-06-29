import 'package:klik_pijaca_app/src/helpers/order.dart';
import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/user.dart';
import 'package:klik_pijaca_app/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

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
                          text: userProvider.userModel.cart.length.toString(),
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
                                        SnackBar(content: Text("not removed")));
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
                  onPressed: () {
                    if (userProvider.userModel.totalCartPrice == 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Your cart is emty',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'You will be charged RSD' +
                                              userProvider
                                                  .userModel.totalCartPrice
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          var uuid = Uuid();
                                          String id = uuid.v4();
                                          _orderServices.createOrder(
                                              userProvider.user.uid,
                                              id,
                                              "some random desc",
                                              "complete",
                                              userProvider
                                                  .userModel.totalCartPrice,
                                              userProvider.userModel.cart);

                                          for (Map cartItem
                                              in userProvider.userModel.cart) {
                                            bool value = await userProvider
                                                .removeFromCart(
                                                    cartItem: cartItem);
                                            if (value) {
                                              userProvider.reloadUserModel();
                                              print("Item added to cart");
                                              _key.currentState.showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          "Removed from Cart!")));
                                            } else {
                                              print("ITEM WAS NOT REMOVED");
                                            }
                                          }
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Order created!")));
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "ACCEPT",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "REJECT",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: CustomText(
                    text: "check out",
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
