import 'package:firebase_core/firebase_core.dart';
import 'package:klik_pijaca_app/src/providers/app.dart';
import 'package:klik_pijaca_app/src/providers/product.dart';
import 'package:klik_pijaca_app/src/providers/user.dart';
import 'package:klik_pijaca_app/src/providers/category.dart';
import 'package:klik_pijaca_app/src/screens/home.dart';
import 'package:klik_pijaca_app/src/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/screens/registration.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
    ChangeNotifierProvider.value(value: ProductProvider.initialize())

  ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Klik pijaca',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreensController(),
    ),));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch(auth.status){
      case Status.Uninitialized:
        return RegistrationScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default: return LoginScreen();
    }
  }
}

