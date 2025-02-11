import 'package:flutter/material.dart';

class LinkText extends StatefulWidget {
  const LinkText(
    this.text, {
    super.key,
    required this.style,
    this.align = TextAlign.start,
    this.onTap,
  });
  final String text;
  final TextStyle style;
  final TextAlign align;
  final void Function()? onTap;

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  late final TextStyle hoverStyle;
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    hoverStyle = widget.style.copyWith(
      color: Colors.amber,
      decoration: TextDecoration.underline,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          textAlign: widget.align,
          style: isHovering ? hoverStyle : widget.style,
        ),
      ),
    );
  }
}
