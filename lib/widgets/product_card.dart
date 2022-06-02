import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 50),
      width: double.infinity,
      height: 400,
      decoration: _cardBorders(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _BackgroundImage(url: product.picture),
          _ProductDetails(id: product.id ?? '', name: product.name),
          Positioned(top: 0, right: 0, child: _PriceTag(price: product.price)),

          if(!product.available) const Positioned(top: 0, left: 0, child: _NotAvailable())

        ],
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0,7),
          blurRadius: 10
        )
      ]
    );
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25)),
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Text(
          'Not available',
          style: TextStyle(color: Colors.white,fontSize: 20),
        ),
      )
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;
  const _PriceTag({Key? key, required this.price,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 120,
      height: 50,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text('\$$price', style: const TextStyle(color: Colors.white, fontSize: 20))
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String name;
  final String id;
  const _ProductDetails({Key? key, required this.name, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(right: 50),
      width: double.infinity,
      height: 70,
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name, 
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            id, 
            style: const TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      )
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;
  const _BackgroundImage({
    Key? key, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'),
        image: url != null ? NetworkImage(url!) : const AssetImage('assets/no-image.png') as ImageProvider,
        fit: BoxFit.cover,
      ),
    );
  }
}