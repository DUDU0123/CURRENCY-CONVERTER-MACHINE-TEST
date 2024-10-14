import 'package:flutter/material.dart';

BoxDecoration commonDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue.shade800, Colors.blue.shade200],
    ),
  );
}
