import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/models/products.dart';
import 'package:klik_pijaca_app/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:black),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Shopping bag",),
        actions: <Widget>  [
          Padding(
              padding: const EdgeInsets.only(top: 2.0,),
          child:  Stack(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.shopping_bag, color: black, size:30), onPressed: (){})
              ),
              Positioned(
                right: 10,
                bottom: 2,
                child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color:grey,
                              offset: Offset(2,3),
                              blurRadius: 3
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:4, right: 4),
                      child: CustomText(text: "2", color:green,size: 17, weight: FontWeight.bold,),
                    )),
              )
            ],
          ),),


        ],
      ),
      backgroundColor: white,
      body: ListView(
        children: <Widget> [
//          Padding(
//            padding: const EdgeInsets.all(10.0),
//            child:Container(
//              height: 120,
//              decoration: BoxDecoration(
//                  color:white,
//                  boxShadow: [
//                    BoxShadow(
//                        color: Colors.green[50],
//                        offset: Offset(3,7),
//                        blurRadius: 30
//                    )
//
//                  ]
//              ),
//              child: Row(
//                children: <Widget> [
//                  Image.asset("images/${product.image}", height: 140),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children:<Widget> [
//                      RichText(text: TextSpan(children:[
//                        TextSpan(text: product.name + "\n", style: TextStyle(color: black, fontSize: 20)),
//                        TextSpan(text: "RSD" + product.price.toString() + "\n", style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.bold)),
//                      ])),
//                      SizedBox(
//                        width: 70,
//                      ),
//                      IconButton(icon: Icon(Icons.delete), onPressed: null)
//
//                    ],
//                  )
//
//                ],
//
//              ),
//            ),
//          )

        ],
      ),
    );
  }
}
