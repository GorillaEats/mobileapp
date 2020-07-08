import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gorilla_eats/data/fooditems.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('jsonFunction', () {
    List<dynamic> decoded;

    Future<void> getJson() async {
      final jsonString = await rootBundle.loadString('test/fooditem_test.json');
      decoded = json.decode(jsonString) as List<dynamic>;
    }

    setUp(() async {
      await getJson();
    });

    test('category fromJson function should return proper object', () {
      final jsonObj = decoded[0] as Map<String, dynamic>;
      final category = FoodCategory.fromJson(jsonObj);

      expect(category.category, 'Entrees');
    });
  });
}
