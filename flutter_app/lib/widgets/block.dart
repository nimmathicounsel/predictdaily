/*
 * PredictDaily
 * Copyright (C) 2026 Jeya Balaji
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';
import '../models/prediction_block.dart';
import '../screens/explain_screen.dart';

class Block extends StatelessWidget {
  final PredictionBlock block;

  const Block({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final firstColor = AppColors
        .indicatorColors[AppConstants.grahaIndicators[block.grahas[0]]];

    final secondColor = AppColors
        .indicatorColors[AppConstants.grahaIndicators[block.grahas[1]]];

    final divideRatio = _calculateRatio(block);
    const dividerWidth = 0.015;

    return SizedBox(
      // width: 78,
      // height: 78,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.black12, width: 1),
          ),
          elevation: 3,
          shadowColor: Colors.black26,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ExplainScreen(block: block)),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                firstColor,
                firstColor,
                Colors.black,
                secondColor,
                secondColor,
              ],
              stops: [
                0.0,
                divideRatio - dividerWidth,
                divideRatio,
                divideRatio + dividerWidth,
                1.0,
              ],
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            // padding: const EdgeInsets.only(top: 8),
            child: Text(
              "${block.date.day}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateRatio(
  PredictionBlock block,
) {

  final totalMinutes =
      const Duration(
        days: 1,
      ).inMinutes;

  Duration elapsed =
      block.dayStarEndTime
          .difference(
        block.sunriseTime,
      );

  if (elapsed.isNegative) {
    elapsed += const Duration(
      days: 1,
    );
  }

  final ratio =
      elapsed.inMinutes /
          totalMinutes;

  return ratio.clamp(
    0.0,
    1.0,
  );
}

  /*
  double _calculateRatio(DateTime dayStarEndTime) {
    final startHour = AppConstants.startHours;

    final startOfCycle = DateTime(
      dayStarEndTime.year,
      dayStarEndTime.month,
      dayStarEndTime.day,
      startHour,
    );

    Duration elapsed = dayStarEndTime.difference(startOfCycle);

    // Handle rollover to next day
    if (elapsed.isNegative) {
      elapsed += const Duration(days: 1);
    }

    final totalMinutes = const Duration(days: 1).inMinutes.toDouble();

    final ratio = elapsed.inMinutes / totalMinutes;

    return ratio.clamp(0.0, 1.0);
  }
  */
}
