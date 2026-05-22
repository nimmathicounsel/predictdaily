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

import 'package:PredictDaily/models/location_info.dart';
import 'package:PredictDaily/models/prediction_block.dart';
import 'package:hive/hive.dart';

part 'prediction_block_cache_entity.g.dart';

@HiveType(typeId: 1)
class PredictionBlockCacheEntity extends HiveObject {
  @HiveField(0)
  String cacheKey;

  @HiveField(1)
  int janmaStar;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  List<int> starIndices;

  @HiveField(4)
  DateTime sunriseTime;

  @HiveField(5)
  DateTime dayStarEndTime;

  @HiveField(6)
  List<int> grahas;

  @HiveField(7)
  DateTime cachedAt;

  PredictionBlockCacheEntity({
    required this.cacheKey,
    required this.janmaStar,
    required this.date,
    required this.starIndices,
    required this.sunriseTime,
    required this.dayStarEndTime,
    required this.grahas,
    required this.cachedAt,
  });

  factory PredictionBlockCacheEntity.fromDomain({
    required int janmaStar,
    required PredictionBlock block,
    required LocationInfo locationInfo
  }) {
    return PredictionBlockCacheEntity(
      cacheKey: buildCacheKey(
        janmaStar,
        block.date,
        locationInfo,
      ),
      janmaStar: janmaStar,
      date: block.date,
      starIndices: block.starIndices,
      sunriseTime: block.sunriseTime,
      dayStarEndTime: block.dayStarEndTime,
      grahas: block.grahas,
      cachedAt: DateTime.now(),
    );
  }

  PredictionBlock toDomain() {
    return PredictionBlock(
      date: date,
      starIndices: starIndices,
      sunriseTime: sunriseTime,
      dayStarEndTime: dayStarEndTime,
      grahas: grahas,
    );
  }

  static String buildCacheKey(
    int janmaStar,
    DateTime date,
    LocationInfo locationInfo,
  ) {
    final normalized =
        "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";

    final lat =
      locationInfo.lat
          .toStringAsFixed(3);

  final lon =
      locationInfo.lon
          .toStringAsFixed(3);

  return "${janmaStar}_"
      "${normalized}_"
      "${lat}_"
      "${lon}";
  }
}