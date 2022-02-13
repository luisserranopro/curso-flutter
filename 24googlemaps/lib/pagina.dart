import 'package:flutter/material.dart';

abstract class Pagina extends StatelessWidget {

  const Pagina(this.leading, this.title);

  final Widget leading;
  final String title;
}