import 'package:flutter/material.dart';

class ItemModel {
  String items;
  IconData ico;
  void Function()? click;

  ItemModel({required this.items, required this.ico, this.click});

}