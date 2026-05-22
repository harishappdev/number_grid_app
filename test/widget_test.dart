import 'package:flutter_test/flutter_test.dart';
import 'package:number_grid_app/app/modules/home/controllers/home_controller.dart';

void main() {
  group('HomeController Tests', () {
    late HomeController controller;

    setUp(() {
      controller = HomeController();
    });

    test('Initial rule is set to odd', () {
      expect(controller.selectedRule.value, HighlightRule.odd);
    });

    test('Odd rule highlights odd numbers correctly', () {
      controller.selectRule(HighlightRule.odd);
      expect(controller.isHighlighted(1), isTrue);
      expect(controller.isHighlighted(2), isFalse);
      expect(controller.isHighlighted(99), isTrue);
      expect(controller.isHighlighted(100), isFalse);
    });

    test('Even rule highlights even numbers correctly', () {
      controller.selectRule(HighlightRule.even);
      expect(controller.isHighlighted(1), isFalse);
      expect(controller.isHighlighted(2), isTrue);
      expect(controller.isHighlighted(99), isFalse);
      expect(controller.isHighlighted(100), isTrue);
    });

    test('Prime rule highlights prime numbers correctly', () {
      controller.selectRule(HighlightRule.prime);
      expect(controller.isHighlighted(1), isFalse);
      expect(controller.isHighlighted(2), isTrue);
      expect(controller.isHighlighted(3), isTrue);
      expect(controller.isHighlighted(4), isFalse);
      expect(controller.isHighlighted(97), isTrue);
      expect(controller.isHighlighted(100), isFalse);
    });

    test('Fibonacci rule highlights Fibonacci numbers correctly', () {
      controller.selectRule(HighlightRule.fibonacci);
      expect(controller.isHighlighted(1), isTrue);
      expect(controller.isHighlighted(2), isTrue);
      expect(controller.isHighlighted(3), isTrue);
      expect(controller.isHighlighted(4), isFalse);
      expect(controller.isHighlighted(5), isTrue);
      expect(controller.isHighlighted(89), isTrue);
      expect(controller.isHighlighted(90), isFalse);
    });
  });
}
