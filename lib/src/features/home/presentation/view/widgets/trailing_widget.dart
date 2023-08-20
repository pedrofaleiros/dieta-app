import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';

import 'meal_bottom_sheet.dart';

class TrailingWidget extends StatelessWidget {
  const TrailingWidget({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(
              Icons.access_time,
              size: 18,
            ),
            const SizedBox(width: 5),
            Container(
              width: 50,
              alignment: Alignment.centerLeft,
              child: Text(
                meal.minutes < 10
                    ? '${meal.hour}:0${meal.minutes}'
                    : '${meal.hour}:${meal.minutes}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () async {
            await showModalBottomSheet(
              backgroundColor: const Color(0xff2d2d2d),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              context: context,
              builder: (context) {
                return MealBottomSheet(meal: meal);
              },
            );
          },
          icon: const Icon(
            Icons.more_vert,
          ),
        ),
      ],
    );
  }
}
