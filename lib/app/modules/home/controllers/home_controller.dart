import 'package:get/get.dart';

enum HighlightRule {
  odd,
  even,
  prime,
  fibonacci,
}

class HomeController extends GetxController {
  final Rx<HighlightRule> selectedRule = HighlightRule.odd.obs;

  static const Set<int> _fibonacciNumbers = {
    1, 2, 3, 5, 8, 13, 21, 34, 55, 89
  };

  void selectRule(HighlightRule rule) {
    selectedRule.value = rule;
  }

  bool isHighlighted(int number) {
    switch (selectedRule.value) {
      case HighlightRule.odd:
        return number % 2 != 0;
      case HighlightRule.even:
        return number % 2 == 0;
      case HighlightRule.prime:
        return _isPrime(number);
      case HighlightRule.fibonacci:
        return _fibonacciNumbers.contains(number);
    }
  }

  bool _isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    for (int i = 5; i * i <= n; i += 6) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
    }
    return true;
  }
}
