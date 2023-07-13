import 'package:flutter/material.dart';



class CustomCheckbox extends StatelessWidget {
  final double size;
  final bool checked;
  final Color? borderColor;
  final void Function()? onTap;

  const CustomCheckbox({
    Key? key,
    required this.size,
    this.onTap,
    this.checked = false, this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.5 : 1.0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: checked ? Color(0xFF67DF65) : Colors.transparent,
            border: Border.all(
              width: 1.5,
              color: checked
                  ? Color(0xFF67DF65)
                  : borderColor ?? Color(0xFFA9A9A9)
            ),
            borderRadius: BorderRadius.circular(
              size / 4,
            ),
          ),
          child: Icon(
            Icons.done,
            color: checked ? Colors.white : Colors.transparent,
            size: size - 3,
          ),
        ),
      ),
    );
  }
}
