import 'package:coffe_app/model/Coffe.dart';
import 'package:coffe_app/secreens/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final size= MediaQuery.of(context).size;
    final _coffe= new Coffe();
    return Scaffold(

      body:GestureDetector(
        onVerticalDragUpdate: (details){
          if(details.primaryDelta < -20){
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 650),
                pageBuilder:(context,animation ,_){
                  return FadeTransition(opacity: animation,child: ProductsPage(),);
                }));
          }
        },

        child: Stack(
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFA89276),
                      Colors.white
                    ]
                  )
                ),
              ),
            ),
            Positioned(
                height: size.height*0.5,
                left: 0,
                right: 0,
                top: size.height*0.14,
                child:Hero(
                  tag:'7',
                  child:Image.asset('assets/photos/1.png'),

                ) ),
            Positioned(
                height: size.height*0.7,
                left: 0,
                right: 0,
                top: size.height*0.30,
                child:Hero(
                  tag:'2',
                  child:Image.asset('assets/photos/2.png'),

                ) ),
            Positioned(
                height: size.height*0.62,
                left: 0,
                right: 0,
                bottom: -(size.height*0.05),
                child:Hero(
                tag:'10',
                 child:Image.asset(
                   'assets/photos/5.png',
                   fit: BoxFit.cover,
                     ),

                ) ),
            Positioned(
                height: size.height*0.90,
                left: 0,
                right: 0,
                bottom: -(size.height*0.77),
                child:Hero(
                  tag:'1',
                  child:Image.asset(
                    'assets/photos/2.png',
                    fit: BoxFit.cover,
                  ),

                ) ),
            Positioned(
                right: 0,
                left: 0,
                height: size.height*0.23,
                top: size.height*0.62,
                child:Image.asset('assets/photos/logo.png') )
          ],

        ),
      ) ,
    );
  }
}
