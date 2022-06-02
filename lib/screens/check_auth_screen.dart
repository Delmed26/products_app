import 'package:flutter/material.dart';
import 'package:products_app/screens/home_screen.dart';
import 'package:products_app/screens/login_screen.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart';


class CheckAuthScreen extends StatelessWidget {

  static const namedRoute = 'checking';
  const CheckAuthScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('Espere');
            

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginScreen(),
                    transitionDuration: const Duration(seconds: 0)
                  )
                );

                Navigator.of(context).pushReplacementNamed(HomeScreen.namedRoute);
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomeScreen(),
                    transitionDuration: const Duration(seconds: 0)
                  )
                );

                Navigator.of(context).pushReplacementNamed(HomeScreen.namedRoute);
              });
            }


            return const Text('Espere');
          }
        )
      ),
    );
  }
}