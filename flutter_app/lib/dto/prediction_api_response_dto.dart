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

import 'package:PredictDaily/dto/day_star_info_dto.dart';

class PredictionApiResponseDto {
  final Map<String, DayStarInfoDto> starsOfDay;

  final Map<int, Map<String, List<int>>> grahaOfStar;

  final String? error;

  PredictionApiResponseDto({
    required this.starsOfDay,
    required this.grahaOfStar,
    required this.error,
  });

  factory PredictionApiResponseDto.fromJson(
    Map<String, dynamic> json,
  ) {
    final starsOfDayJson =
        json["dinaThara"]["starsOfDay"]
            as Map<String, dynamic>;

    final grahaJson =
        json["grahaThara"]["grahaOfStar"]
            as Map<String, dynamic>;

    return PredictionApiResponseDto(
      starsOfDay: starsOfDayJson.map(
        (key, value) => MapEntry(
          key,
          DayStarInfoDto.fromJson(value),
        ),
      ),

      grahaOfStar: grahaJson.map(
        (starKey, value) {
          final dateMap =
              value as Map<String, dynamic>;

          return MapEntry(
            int.parse(starKey),
            dateMap.map(
              (dateKey, grahaValue) => MapEntry(
                dateKey,
                List<int>.from(grahaValue),
              ),
            ),
          );
        },
      ),

      error: json["error"],
    );
  }
}