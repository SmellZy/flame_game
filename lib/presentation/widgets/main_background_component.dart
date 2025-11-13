import 'package:flutter/material.dart';

class MainBackgroundComponent extends StatefulWidget {
  const MainBackgroundComponent({super.key, this.child});

  final Widget? child;

  @override
  State<MainBackgroundComponent> createState() =>
      _MainBackgroundComponentState();
}

class _MainBackgroundComponentState extends State<MainBackgroundComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/loading_bg.png"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(
                  255,
                  165,
                  0,
                  (0.1 * _glowAnimation.value).clamp(0.0, 1.0),
                ),
                BlendMode.lighten,
              ),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
