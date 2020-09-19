import 'file:///C:/Users/jovan/AndroidStudioProjects/app_klik_pijaca/lib/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/helpers/screen_navigation.dart';
import 'package:klik_pijaca_app/src/providers/auth.dart';
import 'package:klik_pijaca_app/src/screens/bag.dart';
import 'package:klik_pijaca_app/src/widgets/bottom_navigation_icons.dart';
import 'package:klik_pijaca_app/src/widgets/categories.dart';
import 'package:klik_pijaca_app/src/widgets/custom_text.dart';
import 'package:klik_pijaca_app/src/widgets/featured_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    print("User!!!!!!!!" + authProvider.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.blueGrey,
        title: CustomText(text:"Klik pijaca", color: Colors.white),
        actions: <Widget> [
          Stack(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart), onPressed: () {}),
            Positioned(
              top: 13,
              right: 13,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
          ],
        ),

          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.notifications_none), onPressed: () {}),
              Positioned(
                top: 13,
                right: 13,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget> [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration( color: Colors.blueGrey),
              accountName: CustomText(text: authProvider.userModel?.name, color: white, weight: FontWeight.bold, size: 18,), accountEmail:CustomText(text: authProvider.userModel?.email, color: white,), ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.person),
              title: CustomText(text: "Account"),
            ),
            ListTile(
              onTap: (){
                changeScreen(context, ShoppingBag());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
          ],

        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(20), ),
                  child: ListTile(
                    leading: Icon(Icons.search, color: green),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: ("Find food that you want..."),
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: Icon(Icons.filter_list, color: green),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Categories(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Featured", size: 20, color: grey),
            ),

            Featured(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Recipes", size: 20, color: grey),
            ),

            // we are using stack so we can add some new widgets on top of the first one
            Padding(padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("images/smoothie.jpg")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite, color: white,),
                      ),
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                            color:white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          children:<Widget> [
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.star, color: Colors.yellow[900], size:20)
                            ),
                            Text("4.5")
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //gradient

                Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.05),
                              Colors.black.withOpacity(0.025),
                            ]
                          )
                        ),
                      ),
                    )),


              ],
            ),)
          ],
        ),
      ),
//      bottomNavigationBar: Container(
//        height: 70,
//        color: white,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget> [
//            BottomNavIcon(
//                image:"home.png",
//                name:"Home"),
//            BottomNavIcon(
//                image:"message.png",
//                name: "Home"),
//            BottomNavIcon(
//                image: "gift.png",
//                name:"Bag",
//                onTap: (){
//                  changeScreen(context, ShoppingBag());
//                },),
//            BottomNavIcon(
//                image:"heartt.png",
//                name:"Home"),
//          ],
//        ),
//      ),
    );
  }
}
