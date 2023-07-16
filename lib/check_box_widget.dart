// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_project_test/check_box_model.dart';
import 'package:provider/provider.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({
    Key? key,
    required this.color,
    required this.isCheck,
    required this.index,
  }) : super(key: key);
  final Color color;
  final bool isCheck;
  final int index;

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            context.read<CheckBoxModel>().onTapItem(widget.index);
          },
          child: IconCheckButtonWidget(widget: widget, controller: _controller),
        ),
      ),
    );
  }
}

class IconCheckButtonWidget extends AnimatedWidget {
  final CheckBoxWidget widget;
  const IconCheckButtonWidget({
    super.key,
    required this.widget,
    required AnimationController controller,
  }) : super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPaint(
          color: widget.color, isCheck: widget.isCheck, controller: _progress),
    );
  }
}

class MyPaint extends CustomPainter {
  final _backgroundPaint = Paint()..strokeWidth = 1.5;
  final _foregroundPaint = Paint()..strokeWidth = 1.5;
  bool isCheck;
  Color color;
  final controller;
  late final Animation<double> circleGrow;
  MyPaint(
      {required this.isCheck, required this.color, required this.controller}) {
    _backgroundPaint.color = color;
    circleGrow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller, 
        curve: Interval(0, 1),
      ),  
    );
  }
  @override
  void paint(Canvas canvas, Size size) {
    if (isCheck) {
      _backgroundPaint.style = PaintingStyle.fill;
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), 20*circleGrow.value, _backgroundPaint);
      _foregroundPaint.color = Colors.white;
      _foregroundPaint.style = PaintingStyle.stroke;
      canvas.drawLine(Offset(size.width / 2.1, (size.height / 1.6)),
          Offset(size.width / 2.8, (size.height / 2)), _foregroundPaint);
      canvas.drawLine(Offset(size.width / 2.1, (size.height / 1.6)),
          Offset(size.width / 1.5, (size.height / 2.5)), _foregroundPaint);
    } else {
      _backgroundPaint.style = PaintingStyle.stroke;
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), 20*circleGrow.value, _backgroundPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as MyPaint).isCheck != isCheck;
  }
}
