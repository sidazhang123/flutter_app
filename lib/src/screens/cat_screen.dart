import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/cat.dart';

class CatScreen extends StatefulWidget {
  CatScreenState createState() => CatScreenState();
}

class CatScreenState extends State<CatScreen> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;
  int tapped;

  @override
  void initState() {
    super.initState();
    tapped = 0;
    const g_dur = 200;

    // AnimationController defines the duration, and Tween defines the value
    // changing within a range (begin/end) at a given pace (curve).
    // Using this changing value in an AnimatedBuilder to animate any Widget.

    catController = AnimationController(
        duration: Duration(milliseconds: g_dur), vsync: this);
    catAnimation = Tween(begin: -35.0, end: -80.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    boxController = AnimationController(
        vsync: this, duration: Duration(milliseconds: g_dur));
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65)
        .animate(CurvedAnimation(parent: boxController, curve: Curves.linear));

    // Animation control
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Aniamation!'),
      ),
      body: GestureDetector(
        child: Center(
          //elements placed from bottom to top layer in a stack

          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
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
      // load the static cat image which is stored in [root_directory]/assets/
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

  // callback to reverse the animation & navigate to "login", the second screen.
  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else {
      boxController.stop();
      catController.forward();
    }
    tapped += 1;
    if (tapped > 4) {
      tapped = 0;
      Navigator.pushNamed(context, '/login');
    }
  }
}
