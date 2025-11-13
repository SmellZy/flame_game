import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RoundedRectangleComponent extends PositionComponent {
  final Color color;
  final double cornerRadius;

  RoundedRectangleComponent({
    required super.size,
    required this.color,
    required this.cornerRadius,
    super.position,
    super.anchor,
  });

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width, height),
        Radius.circular(cornerRadius),
      ),
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }
}
