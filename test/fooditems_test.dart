import 'package:flutter_test/flutter_test.dart';

import 'package:gorilla_eats/data/fooditems.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('jsonFunction', () {
    var decoded = [
      {
        'category': 'Entrees',
        'foods': [
          {
            'foodName': 'Crunchwrap Supreme',
            'subtitle': '2 modifications',
            'modifications': ['Sub beans for beef', 'Fresco style']
          }
        ]
      }
    ];

    test('category fromJson function should return proper object', () {
      final jsonObj = decoded[0];
      final category = FoodCategory.fromJson(jsonObj);

      expect(category.category, 'Entrees');
    });
  });
}
