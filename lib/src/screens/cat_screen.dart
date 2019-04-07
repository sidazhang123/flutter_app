import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const g_dur = 200;
    catController = AnimationController(
        duration: Duration(milliseconds: g_dur), vsync: this);
    catAnimation = Tween(begin: -35.0, end: -80.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    boxController = AnimationController(
        vsync: this, duration: Duration(milliseconds: g_dur));
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65)
        .animate(CurvedAnimation(parent: boxController, curve: Curves.linear));
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.repeat(reverse: true);
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Aniamation!'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
//              buildCatAnimation(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0.0,
          right: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 0.0,
      top: -7.0,
      child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: boxAnimation.value,
              child: child,
              alignment: Alignment.bottomLeft,
            );
          }),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 0.0,
      top: -7.0,
      child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: -boxAnimation.value,
              child: child,
              alignment: Alignment.bottomRight,
            );
          }),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else {
      boxController.stop();
      catController.forward();
    }
  }
}
