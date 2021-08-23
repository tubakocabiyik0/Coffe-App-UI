import 'package:coffe_app/model/Coffe.dart';
import 'package:coffe_app/secreens/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDetailsPage extends StatefulWidget {
  int index;

  ProductDetailsPage(this.index);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final _coffe = new Coffe();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductsPage()));
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Center(
              child: Hero(
                tag: 'textTag',
                child: Text(
                  _coffe.names[(widget.index) - 1],
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          imagePart(),
          pricePart(),
        ],
      ),
    );
  }

  imagePart() {
    return Hero(
      tag: 'assets/photos/${widget.index}.png',
      child: Image.asset(
        'assets/photos/${widget.index}.png',
        height: 310,
      ),
    );
  }

  pricePart() {
    return Positioned(
        left: MediaQuery.of(context).size.width * 0.12,
        bottom: 5,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: 0.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(-70 * value,300* value),
              child: child,
            );
          },
          duration: Duration(milliseconds: 500),
          child: Text(
            '\$ ${_coffe.prices[(widget.index) -1]}'.toString(),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
          ),
        ));
  }
}
