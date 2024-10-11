import 'package:flutter/material.dart';

class VerticalDashedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashHeight;
  final double dashWidth;
  final double dashSpace;

  const VerticalDashedLine({
    super.key,
    this.height = 100,
    this.color = Colors.black,
    this.dashHeight = 5,
    this.dashWidth = 1,
    this.dashSpace = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double totalHeight = constraints.constrainHeight();
          final int dashCount =
              (totalHeight / (dashHeight + dashSpace)).floor();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              dashCount,
              (_) {
                return Container(
                  width: dashWidth,
                  height: dashHeight,
                  color: color,
                  margin: EdgeInsets.only(bottom: dashSpace),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
