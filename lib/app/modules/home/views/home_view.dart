import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text(
          'Number Grid Analyzer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
            fontSize: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRuleSelector(),
            Expanded(
              child: _buildNumberGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'SELECT HIGHLIGHT RULE',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Obx(() {
              return Row(
                children: HighlightRule.values.map((rule) {
                  final isSelected = controller.selectedRule.value == rule;
                  return GestureDetector(
                    onTap: () => controller.selectRule(rule),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        color: isSelected ? null : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        _getRuleLabel(rule),
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF4B5563),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberGrid() {
    return Obx(() {
      // Access value to register dependency for Obx updates
      final _ = controller.selectedRule.value;
      
      return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: 100,
        itemBuilder: (context, index) {
          final number = index + 1;
          final highlighted = controller.isHighlighted(number);

          return AnimatedScale(
            scale: highlighted ? 1.08 : 0.94,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: highlighted
                    ? const LinearGradient(
                        colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: highlighted ? null : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: highlighted ? Colors.transparent : const Color(0xFFE5E7EB),
                  width: 1.0,
                ),
                boxShadow: highlighted
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4F46E5).withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: Text(
                '$number',
                style: TextStyle(
                  color: highlighted ? Colors.white : const Color(0xFF374151),
                  fontWeight: highlighted ? FontWeight.bold : FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      );
    });
  }

  String _getRuleLabel(HighlightRule rule) {
    switch (rule) {
      case HighlightRule.odd:
        return 'Odd';
      case HighlightRule.even:
        return 'Even';
      case HighlightRule.prime:
        return 'Prime';
      case HighlightRule.fibonacci:
        return 'Fibonacci';
    }
  }
}
