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

import 'package:flutter/services.dart';

class AppLocalization {

  static Map<String, dynamic> _localizedValues = {};

  // LOAD JSON
  static Future<void> load(String languageCode) async {

    final jsonString = await rootBundle.loadString(
      'assets/lang/$languageCode.json',
    );

    _localizedValues = json.decode(jsonString);
  }

  // GET STRING
  static String getString(String key) {

    return _localizedValues[key] ?? key;
  }

  // GET LIST
  static List<dynamic> getList(String key) {

    return _localizedValues[key] ?? [];
  }

  // GET MAP
  static Map<String, dynamic> getMap(String key) {

    return Map<String, dynamic>.from(
      _localizedValues[key] ?? {},
    );
  }
}