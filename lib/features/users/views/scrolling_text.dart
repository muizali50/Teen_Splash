import 'package:flutter/material.dart';

class WordByWordFadeInText extends StatefulWidget {
  final String text;

  const WordByWordFadeInText({required this.text, super.key});

  @override
  State<WordByWordFadeInText> createState() => _WordByWordFadeInTextState();
}

class _WordByWordFadeInTextState extends State<WordByWordFadeInText>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    final words = widget.text.split(' ');
    _controllers = List.generate(
      words.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );
    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn),
      );
    }).toList();

    // Start the infinite animations
    _startInfiniteAnimation();
  }

  Future<void> _startInfiniteAnimation() async {
    while (mounted) {
      for (var controller in _controllers) {
        await controller.forward();
        await Future.delayed(const Duration(milliseconds: 10)); // Delay between words
      }

      // Reset all controllers to replay the animation
      for (var controller in _controllers) {
        controller.reset();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.text.split(' ');

    return Wrap(
      spacing: 4.0, // Space between words
      children: List.generate(words.length, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _animations[index].value,
              child: child,
            );
          },
          child: Text(
            words[index],
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFBFBFB),
            ),
          ),
        );
      }),
    );
  }
}
