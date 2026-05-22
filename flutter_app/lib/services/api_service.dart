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

import 'dart:convert';

import 'package:PredictDaily/core/constants/api_constants.dart';
import 'package:PredictDaily/dto/prediction_api_response_dto.dart';
import 'package:PredictDaily/models/location_info.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      ApiConstants.fetchUrl;

  Future<PredictionApiResponseDto>
      fetchPredictions({
    required LocationInfo locationInfo,
    required List<int> janmaStars,
    required List<DateTime> dates,
  }) async {
    final requestBody = {
      "locationInfo": locationInfo.toJson(),
      "dates": dates
          .map(_formatDate)
          .toList(),
      "janmaStars": janmaStars,
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to fetch prediction data",
      );
    }

    final decoded =
        jsonDecode(response.body);

    return PredictionApiResponseDto
        .fromJson(decoded);
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }
}