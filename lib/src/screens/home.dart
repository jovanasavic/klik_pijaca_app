import 'package:klik_pijaca_app/src/helpers/screen_navigation.dart';
import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/product.dart';
import 'package:klik_pijaca_app/src/providers/user.dart';
import 'package:klik_pijaca_app/src/providers/category.dart';
import 'package:klik_pijaca_app/src/screens/cart.dart';
import 'package:klik_pijaca_app/src/screens/order.dart';
import 'package:klik_pijaca_app/src/screens/product_search.dart';
import 'package:klik_pijaca_app/src/widgets/categories.dart';
import 'package:klik_pijaca_app/src/widgets/custom_text.dart';
import 'package:klik_pijaca_app/src/widgets/featured_products.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.blueGrey,
        title: CustomText(text: "Klik pijaca", color: Colors.white),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    changeScreen(context, CartScreen());
                  }),
              Positioned(
                  top: 13,
                  right: 13,
                  child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)))),
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
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              accountName: CustomText(
                text: userProvider.userModel?.name,
                color: Colors.white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.person),
              title: CustomText(text: "Account"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, OrderScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "Orders"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0, bottom: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.search, color: Colors.green),
                          title: TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoadingState();
                              await productProvider.search(
                                  productName: pattern);
                              changeScreen(context, ProductSearchScreen());
                              app.changeLoadingState();
                            },
                            decoration: InputDecoration(
                              hintText: ("Find food that you want..."),
                              border: InputBorder.none,
                            ),
                          ),
                          trailing:
                              Icon(Icons.filter_list, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {
                              //app.changeLoadingState();
                              await productProvider.loadProductsByCategory(
                                  categoryName:
                                      categoryProvider.categories[index].name);
                              changeScreen(
                                  context,
                                  CategoryScreen(
                                    categoryModel:
                                        categoryProvider.categories[index],
                                  ));
                            },
                            child: Category(
                              category: categoryProvider.categories[index],
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Featured",
                          size: 20,
                          color: grey,
                        ),
                        CustomText(
                          text: "see all",
                          size: 14,
                          color: green,
                        ),
                      ],
                    ),
                  ),
                  Featured(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                        text: "Recipes", size: 20, color: Colors.grey),
                  ),

                  // we are using stack so we can add some new widgets on top of the first one
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40)),
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
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(Icons.star,
                                            color: Colors.yellow[900],
                                            size: 20)),
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
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
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
                                    ])),
                          ),
                        )),
                      ],
                    ),
                  )
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
