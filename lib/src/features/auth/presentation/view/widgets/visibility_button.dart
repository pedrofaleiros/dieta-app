import 'package:flutter/material.dart';

class VisibilityButton extends StatelessWidget {
  const VisibilityButton({
    super.key,
    required this.hideText,
    required this.onPress,
  });

  final bool hideText;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPress(),
      icon: hideText
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );
  }
}
