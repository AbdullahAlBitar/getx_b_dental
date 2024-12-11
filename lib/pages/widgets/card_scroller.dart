import 'package:flutter/material.dart';

class CardScroller extends StatefulWidget {
  const CardScroller({super.key, this.height = 200, this.scrollDirection = Axis.vertical, required this.children});
  final double height;
  final List<Widget> children;
  final Axis scrollDirection;

  @override
  State<CardScroller> createState() => _CardScrollerState();
}

class _CardScrollerState extends State<CardScroller> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      height: widget.height,
      child: SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        child: widget.scrollDirection == Axis.vertical? Column(children: widget.children) : Row(children: widget.children,),
      ),
    );
  }
}
