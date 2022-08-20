import 'package:charge_car/constants/index.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      this.text,
      this.press,
      this.textColor,
      this.backgroundColor,
      this.isTextBold})
      : super(key: key);
  final String? text;
  final Function? press;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isTextBold;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        RadiusSize.popupMenuBorderRadius))),
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: FontSizes.label,
              color: textColor,
            ))),
        onPressed: press as void Function()?,
        child: Text(
          text ?? " ",
          style: TextStyle(
              fontSize: FontSizes.label,
              color: textColor,
              fontWeight:
                  isTextBold ?? false ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}

class DefaultButtonWidthDynamic extends StatelessWidget {
  const DefaultButtonWidthDynamic(
      {Key? key,
      this.widget,
      this.press,
      this.textColor,
      this.backgroundColor,
      this.isTextBold})
      : super(key: key);
  final Widget? widget;
  final Function? press;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? isTextBold;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        RadiusSize.popupMenuBorderRadius))),
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: FontSizes.subtitle2,
              color: textColor,
            ))),
        onPressed: press as void Function()?,
        child: widget ?? const SizedBox(),
      ),
    );
  }
}