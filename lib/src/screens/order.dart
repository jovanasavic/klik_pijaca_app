import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/models/order.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/user.dart';
import 'package:klik_pijaca_app/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Orders",
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
      body: ListView.builder(
          itemCount: userProvider.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = userProvider.orders[index];
            return ListTile(
              leading: CustomText(
                text: "RSD" + _order.total.toString(),
                weight: FontWeight.bold,
              ),
              title: Text(_order.description),
              subtitle: Text(
                  DateTime.fromMillisecondsSinceEpoch(_order.createdAt)
                      .toString()),
              trailing: CustomText(
                text: _order.status,
                color: green,
              ),
            );
          }),
    );
  }
}
