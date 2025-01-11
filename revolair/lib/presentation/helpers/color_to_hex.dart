import 'package:flutter/material.dart';
Color getColorFromHex(String hex){
    hex = hex.replaceFirst('#', '');
    if(hex.length == 6){
      hex = 'FF$hex';
    }
    return Color(int.parse("0x$hex"));
  }