import 'dart:io';

import 'package:flutter/cupertino.dart';

class AppClothes{
  final String name;
  final File file;
  final String dateCreated;
  final TextEditingController controller;

  AppClothes({required this.name, required this.file, required this.dateCreated, required this.controller});
}