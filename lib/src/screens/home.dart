import 'package:klik_pijaca_app/src/helpers/screen_navigation.dart';
import 'package:klik_pijaca_app/src/helpers/style.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/product.dart';
import 'package:klik_pijaca_app/src/providers/user.dart';
import 'package:klik_pijaca_app/src/providers/category.dart';
import 'package:klik_pijaca_app/src/screens/cart.dart';
import 'package:klik_pijaca_app/src/screens/order.dart';
import 'package:klik_pijaca_app/src/screens/product_search.dart';
import 'package:klik_pijaca_app/src/widgets/bottom_navigation_icons.dart';
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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.green[900]),
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Image.asset("images/logoAppBar.png"),
              ),
              actions: <Widget>[
                Stack(
                  children: <Widget>[
                    IconButton(
                        icon: new Image.asset('images/cartIcon.png'),
                        onPressed: () {
                          changeScreen(context, CartScreen());
                        }),
                  ],
                ),
              ],
            )),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
//            Image.asset("images/logo.png"),
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/klikpijacaapp-3072c.appspot.com/o/logo.png?alt=media&token=4d732787-a583-497c-8bca-66b04124f63c'),
                    ),
                    color: Colors.white),
                // accountName: Padding(
                //   padding: const EdgeInsets.only(right: 20.0, top: 32.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       CustomText(
                //         text: userProvider.userModel?.name,
                //         color: Colors.green[900],
                //         weight: FontWeight.bold,
                //         size: 16,
                //       ),
                //     ],
                //   ),
                // ),
                accountEmail: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: userProvider.userModel?.email,
                        color: Colors.green[900],
                      ),
                    ],
                  ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 8.0, right: 8.0, bottom: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading:
                                  Icon(Icons.search, color: Colors.green[900]),
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
                                  hintText: ("Pretraži..."),
                                  border: InputBorder.none,
                                ),
                              ),
                              trailing: Icon(Icons.filter_list,
                                  color: Colors.green[900]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
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
                                    categoryName: categoryProvider
                                        .categories[index].name);
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
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: "Preporučeni proizvodi",
                            size: 14,
                            color: grey,
                          ),
                        ],
                      ),
                    ),
                    Featured(),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CustomText(
                          text: "Sezonske akcije",
                          size: 14,
                          color: Colors.grey),
                    ),

                    // we are using stack so we can add some new widgets on top of the first one
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ], borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset("images/akcija.jpg")),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomAppBar(
              color: Color.fromRGBO(0, 86, 45, 1),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: new Image.asset('images/home.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: new Image.asset('images/categories.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: new Image.asset('images/chart.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: new Image.asset('images/wishlist.png'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
