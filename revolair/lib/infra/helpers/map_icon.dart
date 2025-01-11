   import 'package:flutter/material.dart';

IconData mapIcon(String iconName) {
    switch (iconName) {
      case 'sentiment_very_satisfied':
        return Icons.sentiment_very_satisfied;
      case 'sentiment_satisfied':
        return Icons.sentiment_satisfied;
      case 'sentiment_neutral':
        return Icons.sentiment_neutral;
      case 'sentiment_dissatisfied':
        return Icons.sentiment_dissatisfied;
      case 'sentiment_very_dissatisfied':
        return Icons.sentiment_very_dissatisfied;
      case 'sentiment_very_dissatisfied_outlined':
        return Icons.sentiment_very_dissatisfied_outlined;
      case 'sentiment_satisfied_alt':
        return Icons.sentiment_satisfied_alt;
      case 'mood_bad':
        return Icons.mood_bad;
      default:
        return Icons.help; 
    }
  }