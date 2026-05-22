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

class DayStarInfoDto {
  final int dayStarEndTime;
  final List<int> dayStars;
  final DateTime sunriseTime;

  DayStarInfoDto({
    required this.dayStarEndTime,
    required this.dayStars,
    required this.sunriseTime,
  });

  factory DayStarInfoDto.fromJson(Map<String, dynamic> json) {
    return DayStarInfoDto(
      dayStarEndTime: json["dayStarEndTime"],
      dayStars: List<int>.from(json["dayStars"]),
      sunriseTime: DateTime.parse(json['sunriseTime']),
    );
  }
}
