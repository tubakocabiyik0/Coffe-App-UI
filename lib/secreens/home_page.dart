import 'package:coffe_app/model/Coffe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final count = new Coffe().names.length;
  PageController _pageController = PageController(viewportFraction: 0.35);
  double _currentPage = 0.0;

  void _coffeScrollListener() {
    setState(() {
      _currentPage = _pageController.page;
    });
  }

  @override
  void initState() {
    _pageController.addListener(() {
      _coffeScrollListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(() {
      _coffeScrollListener();
    });
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    final height = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              bottom: -height.height*0.2,
              height: height.height*0.25,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape:BoxShape.circle,
                  boxShadow:[
                    BoxShadow(
                      blurRadius: 100,
                      spreadRadius: 45,
                      color: Colors.brown.shade300
                    ),
                  ] ,
                ),
              )),
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            height: 120,
            child: Container(
              color: Colors.purple.shade200,
            ),
          ),
          Transform.scale(
            scale: 1.8,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                itemCount: new Coffe().names.length + 1,
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }

                  final coffe = 'assets/photos/${index}.png';
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  return Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                              0.0,
                              MediaQuery.of(context).size.height /
                                  2.6 *
                                  (1 - value).abs())
                          ..scale(value),
                        child:
                            Opacity(opacity: opacity, child: Image.asset(coffe))),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
