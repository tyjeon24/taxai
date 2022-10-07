import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  Color? color = Colors.green[400]!;
  String? textString = "";
  Image? icon;
  AnimatedButton({Key? key, this.color, this.textString, this.icon})
      : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  double width = 0.5;
  double opacity = 0.3;
  double scale = 1.0;

  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        border: Border.all(
          width: width,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(opacity),
            blurRadius: 4,
            offset: Offset(2, 4), // changes position of shadow
          ),
        ],
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(0, 100)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  backgroundColor: MaterialStateProperty.all(widget.color!),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  )),
              onPressed: () {},
              onHover: (isHovered) {
                setState(() {
                  scale = isHovered ? 1.1 : 1;
                  width = isHovered ? 1 : 0.5;
                  opacity = isHovered ? 0.8 : 0.3;
                });
              },
              icon: widget.icon!,
              label: Text(widget.textString!, textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}
