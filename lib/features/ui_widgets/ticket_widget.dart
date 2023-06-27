import 'package:flutter/material.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.color = Colors.white,
    this.isCornerRounded = false,
  }) : super(key: key);
  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: widget.isCornerRounded
              ? BorderRadius.circular(16)
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
        ),
        child: widget.child,
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..addOval(
        Rect.fromCircle(center: Offset(0, size.height * 0.75), radius: 20),
      )
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width, size.height * 0.75),
          radius: 20,
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
