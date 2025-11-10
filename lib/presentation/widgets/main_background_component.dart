import 'package:flutter/material.dart';

class MainBackgroundComponent extends StatefulWidget {
  const MainBackgroundComponent({super.key, this.colorFilter, this.child});

  final ColorFilter? colorFilter;
  final Widget? child;
  

  @override
  State<MainBackgroundComponent> createState() =>
      _MainBackgroundComponentState();
}

class _MainBackgroundComponentState extends State<MainBackgroundComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/loading_bg.png"),
          fit: BoxFit.fill,
          colorFilter: widget.colorFilter,
        ),
      ),
      child: widget.child,
    );
  }
}
