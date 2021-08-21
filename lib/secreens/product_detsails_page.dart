import 'package:coffe_app/model/Coffe.dart';
import 'package:flutter/material.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: Text(
                _coffe.names[(widget.index) - 1],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(height: 70,),
          imagePart()
        ],
      ),
    );
  }

  imagePart() {
  return Image.asset('assets/photos/${widget.index}.png',height: 450,);

  }
}
