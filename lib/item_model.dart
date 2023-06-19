import 'package:flutter/material.dart';

class ItemModel {
  String items;
  IconData ico;
  void Function()? click;
  final Color? color;


  ItemModel({required this.items, required this.ico, this.click, this.color});

}