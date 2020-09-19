import 'package:firebase_core/firebase_core.dart';
import 'package:klik_pijaca_app/src/providers/auth.dart';
import 'package:klik_pijaca_app/src/screens/home.dart';
import 'package:klik_pijaca_app/src/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/screens/registration.dart';
import 'package:provider/provider.dart';
import 'package:klik_pijaca_app/src/widgets/loading.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize())
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
    final auth = Provider.of<AuthProvider>(context);
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

