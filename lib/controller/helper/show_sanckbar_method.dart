
  import 'package:flutter/material.dart';
import 'package:todoapp/controller/const.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.only(
          bottom: height - 150,
          left: 20,
          right: 20,
        ),
        content: Text(message),
      ),
    );
  }
