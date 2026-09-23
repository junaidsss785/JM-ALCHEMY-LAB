import 'package:flutter/material.dart';

class ElementModel {
  final String id;
  final String name;
  final String formula;
  final String category;
  final String iconSymbol;
  final Color themeColor;
  final int atomicNumber;
  final double atomicMass;
  final String stateOfMatter;
  final String realWorldUse;
  final String bondingType;
  final List<String>? recipe;

  ElementModel({
    required this.id,
    required this.name,
    required this.formula,
    required this.category,
    required this.iconSymbol,
    required this.themeColor,
    required this.atomicNumber,
    required this.atomicMass,
    required this.stateOfMatter,
    required this.realWorldUse,
    required this.bondingType,
    this.recipe,
  });

  bool get isBaseElement => recipe == null || recipe!.isEmpty;

  factory ElementModel.fromJson(Map<String, dynamic> json) {
    return ElementModel(
      id: json['id'],
      name: json['name'],
      formula: json['formula'],
      category: json['category'],
      iconSymbol: json['iconSymbol'],
      themeColor: Color(int.parse(json['themeColor'])),
      atomicNumber: json['atomicNumber'],
      atomicMass: (json['atomicMass'] as num).toDouble(),
      stateOfMatter: json['stateOfMatter'],
      realWorldUse: json['realWorldUse'],
      bondingType: json['bondingType'],
      recipe: json['recipe'] != null ? List<String>.from(json['recipe']) : null,
    );
  }
}
