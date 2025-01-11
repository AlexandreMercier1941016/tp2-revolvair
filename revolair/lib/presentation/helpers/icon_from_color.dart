import 'package:flutter/material.dart';

IconData getEmojiForColor(String color) {
  switch (color) {
    case "ffef8533":
      return Icons.mood_bad;
    case "ff4ba162":
      return Icons.sentiment_very_satisfied;
    case "fff0b439":
      return Icons.sentiment_neutral;
    case "ffea3324":
      return Icons.sentiment_very_dissatisfied;
    default:
      return Icons.help;
  }
}
