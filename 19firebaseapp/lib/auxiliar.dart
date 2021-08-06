import 'package:flutter/material.dart';

void mostrarSnackBar(String message, BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 1200),
  ));
}
