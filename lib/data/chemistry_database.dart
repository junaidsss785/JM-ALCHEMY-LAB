import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/element_model.dart';

class JMAlchemyDatabase {
  static Map<String, ElementModel> elements = {};

  // Function to load all chemistry elements from JSON asset
  static Future<void> loadDatabase() async {
    final String response = await rootBundle.loadString('assets/data/reactions.json');
    final List<dynamic> data = json.decode(response);

    elements.clear();
    for (var item in data) {
      final element = ElementModel.fromJson(item);
      elements[element.id] = element;
    }
  }

  // Logic to combine two elements
  static ElementModel? combineElements(String id1, String id2) {
    for (var element in elements.values) {
      if (element.recipe != null && element.recipe!.length == 2) {
        if ((element.recipe![0] == id1 && element.recipe![1] == id2) ||
            (element.recipe![0] == id2 && element.recipe![1] == id1)) {
          return element;
        }
      }
    }
    return null;
  }
}
