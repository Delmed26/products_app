import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  
  static const namedRoute = 'home';

  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () async {
            await authService.logout();
            Navigator.pushReplacementNamed(context, LoginScreen.namedRoute);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: (() {
            productService.selectedProduct = productService.products[index].copy();
            Navigator.pushNamed(context, ProductScreen.namedRoute);
          }),
          child: ProductCard(product: productService.products[index])
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectedProduct = Product(
            available: false,
            name: '',
            price: 0
          );
          Navigator.pushNamed(context, ProductScreen.namedRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}