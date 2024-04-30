import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loaderWidget() {
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        color: Colors.white.withOpacity(0.95),
        child: Lottie.asset(
          'assets/lotties/loader.json',
          width: 60,
          height: 60
        ),
      ),
    )
  );
}