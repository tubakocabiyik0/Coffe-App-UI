import 'package:coffe_app/model/Coffe.dart';
import 'package:coffe_app/secreens/home_page.dart';
import 'package:coffe_app/secreens/product_detsails_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final count = new Coffe().names.length;
  PageController _pageController = PageController(viewportFraction: 0.35);
  PageController _nameController = PageController();
  double _currentPage = 0.0;
  double _currentName = 0.0;
  Coffe _coffe = new Coffe();

  void _coffeScrollListener() {
    setState(() {
      _currentPage = _pageController.page;
    });
  }

  void _nameScrollListener() {
    setState(() {
      _currentName = _nameController.page;
    });
  }

  @override
  void initState() {
    _pageController.addListener(() {
      _coffeScrollListener();
    });
    _nameController.addListener(() {
      _nameScrollListener();
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(() {
      _coffeScrollListener();
    });
    _nameController.removeListener(() {
      _nameScrollListener();
    });
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    final height = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              bottom: -height.height * 0.2,
              height: height.height * 0.25,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 100,
                      spreadRadius: 45,
                      color: Colors.brown.shade300,
                    ),
                  ],
                ),
              )),
          Transform.scale(
            scale: 1.8,
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: "images",
              child: PageView.builder(
                  onPageChanged: (value) {
                    if (value + 1 == _coffe.prices.length) {

                      // ignore: unnecessary_statements
                      _pageController.position.physics.parent ==
                          NeverScrollableScrollPhysics();
                    }

                    if (value < _coffe.prices.length) {
                      _nameController.animateToPage(value,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                    }
                  },
                  itemCount: new Coffe().names.length + 1,
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox.shrink();
                    }
                    print(index);
                    final coffe = 'assets/photos/${index}.png';
                    final result = _currentPage - index + 1;
                    final value = -0.4 * result + 1;
                    final opacity = value.clamp(0.0, 1.0);

                    return
                       Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (context, animation, _) {
                                  return FadeTransition(opacity: animation,
                                    child: ProductDetailsPage(index),);
                                }));
                          },
                          child: Transform(
                              alignment: Alignment.bottomCenter,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..translate(
                                    0.0,
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height /
                                        2.6 *
                                        (1 - value).abs())
                                ..scale(value),
                              child: Opacity(
                                  opacity: opacity, child: Image.asset(coffe)))),

                    );
                  }),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            height: 120,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _coffe.names.length,
                      controller: _nameController,
                      itemBuilder: (context, index) {
                        final opacity =
                        (1 - (index - _currentName).abs()).clamp(0.0, 1.0);
                        return Opacity(
                            opacity: opacity,
                            child: Text(
                              _coffe.names[index],
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ));
                      }),
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      '\$${_coffe.prices[_currentPage.toInt()].toString()}',
                      style: TextStyle(fontSize: 30),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
