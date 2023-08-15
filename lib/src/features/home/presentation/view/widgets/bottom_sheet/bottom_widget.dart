import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              overlayColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 12, top: 12),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
