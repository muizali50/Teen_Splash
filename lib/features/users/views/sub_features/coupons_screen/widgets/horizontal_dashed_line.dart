import 'package:flutter/material.dart';

class HorizontalDashedLine extends StatelessWidget {
  final double width;
  final Color color;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;

  const HorizontalDashedLine({
    super.key,
    this.width = 200,
    this.color = Colors.black,
    this.dashWidth = 10,
    this.dashHeight = 1,
    this.dashSpace = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double totalWidth = constraints.constrainWidth();
          final int dashCount = (totalWidth / (dashWidth + dashSpace)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              dashCount,
              (_) {
                return Container(
                  width: dashWidth,
                  height: dashHeight,
                  color: color,
                  margin: EdgeInsets.only(right: dashSpace),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
