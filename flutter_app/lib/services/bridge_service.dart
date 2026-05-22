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

import 'dart:collection';

import 'package:hive/hive.dart';

import '../cache/entities/prediction_block_cache_entity.dart';
import '../dto/prediction_api_response_dto.dart';
import '../models/location_info.dart';
import '../models/person.dart';
import '../models/prediction_block.dart';
import '../models/prediction_matrix.dart';
import '../models/prediction_person.dart';
import 'api_service.dart';

class BridgeService {
  final ApiService apiService;

  BridgeService({
    required this.apiService,
  });

  static const String _boxName =
      "prediction_cache";

  Future<PredictionMatrix>
      fetchPredictionMatrix({
    required List<Person> persons,
    required List<DateTime> dates,
    required LocationInfo locationInfo,
  }) async {
    final normalizedDates =
        dates.map(_normalizeDate).toList();

    final box =
        Hive.box<PredictionBlockCacheEntity>(
      _boxName,
    );

    final Map<String, PredictionBlock>
        allBlocks = {};

    final List<Person> missingPersons = [];
    final List<DateTime> missingDates = [];

    // Step 1:
    // Read cache and detect misses

    for (final person in persons) {
      for (final date in normalizedDates) {
        final cacheKey =
            PredictionBlockCacheEntity
                .buildCacheKey(
          person.star,
          date,
          locationInfo,
        );

        final cached = box.get(cacheKey);

        if (cached != null) {
          allBlocks[cacheKey] =
              cached.toDomain();
        } else {
          if (!missingPersons.contains(
            person,
          )) {
            missingPersons.add(person);
          }

          if (!missingDates.contains(
            date,
          )) {
            missingDates.add(date);
          }
        }
      }
    }

    // Step 2:
    // Fetch missing data from server

    if (missingPersons.isNotEmpty &&
        missingDates.isNotEmpty) {
      final dto =
          await apiService.fetchPredictions(
        locationInfo: locationInfo,
        janmaStars: missingPersons
            .map((e) => e.star)
            .toList(),
        dates: missingDates,
      );

      if (dto.error != null) {
        throw Exception(dto.error);
      }

      await _mergeApiResponseIntoCache(
        dto: dto,
        persons: missingPersons,
        box: box,
        allBlocks: allBlocks,
        locationInfo: locationInfo,
      );
    }

    // Step 3:
    // Build final matrix

    return _buildPredictionMatrix(
      persons: persons,
      dates: normalizedDates,
      allBlocks: allBlocks,
      locationInfo: locationInfo,
    );
  }

  DateTime _normalizeDate(
    DateTime date,
  ) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  Future<void> _mergeApiResponseIntoCache({
  required PredictionApiResponseDto dto,
  required List<Person> persons,
  required Box<PredictionBlockCacheEntity> box,
  required Map<String, PredictionBlock> allBlocks,
  required LocationInfo locationInfo,
}) async {
  for (final person in persons) {
    final grahaByDate =
        dto.grahaOfStar[person.star];

    if (grahaByDate == null) {
      continue;
    }

    for (final entry
        in grahaByDate.entries) {
      final dateString = entry.key;

      final grahaValues = entry.value;

      final dayInfo =
          dto.starsOfDay[dateString];

      if (dayInfo == null) {
        continue;
      }

      final date =
          DateTime.parse(dateString);

      final sunriseTime =
    dayInfo.sunriseTime;

final dayStarEndTime =
    _buildDayStarEndTime(
  sunriseTime,
  dayInfo.dayStarEndTime,
);

      final block = PredictionBlock(
        date: date,
        starIndices:
            dayInfo.dayStars,
        sunriseTime:
          sunriseTime,
        dayStarEndTime:
            dayStarEndTime,
        grahas: grahaValues,
      );

      final cacheEntity =
          PredictionBlockCacheEntity
              .fromDomain(
        janmaStar: person.star,
        block: block,
        locationInfo: locationInfo,
      );

      await box.put(
        cacheEntity.cacheKey,
        cacheEntity,
      );

      allBlocks[cacheEntity.cacheKey] =
          block;
    }
  }
}

PredictionMatrix _buildPredictionMatrix({
  required List<Person> persons,
  required List<DateTime> dates,
  required Map<String, PredictionBlock>
      allBlocks,
  required LocationInfo locationInfo,
}) {
  final LinkedHashMap<
          Person,
          PredictionPerson>
      matrixPersons =
      LinkedHashMap();

  for (final person in persons) {
    final SplayTreeMap<
            DateTime,
            PredictionBlock>
        predictions =
        SplayTreeMap(
      (a, b) => a.compareTo(b),
    );

    for (final date in dates) {
      final cacheKey =
          PredictionBlockCacheEntity
              .buildCacheKey(
        person.star,
        date,
        locationInfo,
      );

      final block =
          allBlocks[cacheKey];

      if (block != null) {
        predictions[date] = block;
      }
    }

    matrixPersons[person] =
        PredictionPerson(
      predictions: predictions,
    );
  }

  return PredictionMatrix(
    persons: matrixPersons,
  );
}

DateTime _buildDayStarEndTime(
  DateTime sunriseTime,
  int minutesFromSunrise,
) {

  return sunriseTime.add(
    Duration(
      minutes: minutesFromSunrise,
    ),
  );
}
}