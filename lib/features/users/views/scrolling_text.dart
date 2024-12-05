import 'package:flutter/material.dart';

class HorizontalScrollingText extends StatefulWidget {
  final String text;

  const HorizontalScrollingText({
    required this.text,
    super.key,
  });

  @override
  State<HorizontalScrollingText> createState() =>
      _HorizontalScrollingTextState();
}

class _HorizontalScrollingTextState extends State<HorizontalScrollingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  double textWidth = 0;
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // Calculate text width after layout
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFBFBFB),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        setState(
          () {
            textWidth = textPainter.width;
          },
        );
      },
    );

    // Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(); // Repeat the animation infinitely

    // Animation with Linear movement
    _animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          if (textWidth == 0) {
            return const SizedBox
                .shrink(); // Avoid rendering before text width is calculated
          }

          // Calculate the x offset
          final fullScrollWidth = screenWidth + textWidth;
          final xOffset = _animation.value * fullScrollWidth - textWidth;

          return Transform.translate(
            offset: Offset(xOffset, 0),
            child: child,
          );
        },
        child: Text(
          widget.text,
          style: const TextStyle(
            fontFamily: 'Lexend',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFBFBFB),
          ),
        ),
      ),
    );
  }
}
