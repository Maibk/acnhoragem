import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularLoader extends StatefulWidget {

  final double diameter;
  final Color color;
  const CircularLoader({Key? key,this.diameter=30,this.color= Colors.blue}):super(key: key,);

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> with TickerProviderStateMixin{

  late AnimationController controller;

  @override
  void initState() {
    controller=AnimationController(vsync: this,duration: const Duration(seconds: 1));
    controller.addListener(() {
      setState(() {

      });
    });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
          angle: getRadian(controller.value*360),
          child: Container(
              width: widget.diameter,height: widget.diameter,
              child: CircularProgressIndicator(value: 0.25,strokeWidth: 5,
                color: widget.color,))),
    );
  }


  double getRadian(double degree){
    return (degree*math.pi)/180;
  }
}