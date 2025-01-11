import 'package:flutter/material.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:stacked_services/stacked_services.dart';

enum SnackbarType { alert }

void registerErrorSnackbar() {
  final snackBarService = locator<SnackbarService>();

  snackBarService.registerCustomSnackbarConfig(
    variant: SnackbarType.alert,
    config: SnackbarConfig(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
    ),
  );
}