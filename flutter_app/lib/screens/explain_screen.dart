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

import 'package:PredictDaily/core/constants/app_colors.dart';
import 'package:PredictDaily/core/constants/app_constants.dart';
import 'package:PredictDaily/utils/decor.dart';
import 'package:PredictDaily/widgets/app_footer.dart';
import 'package:PredictDaily/widgets/app_header.dart';
import 'package:PredictDaily/widgets/block.dart';
import 'package:flutter/material.dart';

import '../localization/app_localization.dart';
import '../models/prediction_block.dart';
import '../widgets/block.dart';

class ExplainScreen extends StatelessWidget {
  final PredictionBlock block;

  const ExplainScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    String dateStr = Decor.dateToStr(block.date);
    String sunriseStr = "Sunrise time : ${Decor.timeToStr(block.sunriseTime)}";

    final List<String> stars = List<String>.from(
      AppLocalization.getList('stars'),
    );

    final List<String> grahas = List<String>.from(
      AppLocalization.getList('grahas'),
    );

    final translations = AppLocalization.getMap('wordTranslations');

    final divideRatio = Block.calculateRatio(block);

    List<bool> expander = [divideRatio >= 0.5, divideRatio < 0.5];

    return Scaffold(
      appBar: const AppHeader(title: "Home"),
      bottomNavigationBar: const AppFooter(),
      backgroundColor: AppColors.explainBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.softWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      dateStr,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      sunriseStr,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: block.starIndices.length,
                itemBuilder: (context, index) {
                  final starIndex = block.starIndices[index];

                  final grahaIndex = block.grahas[index];

                  final matchedWords = AppConstants.wordMatch[grahaIndex];

                  final translatedWords = matchedWords
                      .map((k) => translations["$k"]?.toString() ?? '')
                      .where((e) => e.isNotEmpty)
                      .toList();

                  final timeText = _buildDisplayTime(block);

                  final bgColor =
                      AppColors.indicatorColors[AppConstants
                          .grahaIndicators[grahaIndex]];

                  return Card(
                    color: AppColors.softWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 1.5,
                    shadowColor: Colors.black12,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ExpansionTile(
                      title: Text(
                        "${stars[starIndex]} "
                        "${index == 0 ? 'till' : 'after'} "
                        "$timeText",
                      ),
                      initiallyExpanded: expander[index],
                      backgroundColor: bgColor.withOpacity(0.18),
                      collapsedBackgroundColor: bgColor,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                grahas[grahaIndex],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                translatedWords.join(', '),
                                style: const TextStyle(
                                  fontSize: 17,
                                  height: 1.7,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildDisplayTime(PredictionBlock block) {
    final spilled = block.dayStarEndTime.day != block.sunriseTime.day;

    final hour = block.dayStarEndTime.hour;

    final minute = block.dayStarEndTime.minute;

    final time =
        "${hour.toString().padLeft(2, '0')}:"
        "${minute.toString().padLeft(2, '0')}";

    if (spilled) {
      return "Next day $time";
    }

    return time;
  }

  /*
    int hour = block.dayStarEndTime.hour;

    final minute = block.dayStarEndTime.minute;

    final baseDate = DateTime(
      block.date.year,
      block.date.month,
      block.date.day,
    );

    final endDate = DateTime(
      block.dayStarEndTime.year,
      block.dayStarEndTime.month,
      block.dayStarEndTime.day,
    );

    final spilledToNextDay = endDate.isAfter(baseDate);

    if (spilledToNextDay) {
      hour += 24;
    }

    return "${hour.toString().padLeft(2, '0')}:"
        "${minute.toString().padLeft(2, '0')}";
  }
  */
}
