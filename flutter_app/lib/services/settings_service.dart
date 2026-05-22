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

import '../core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {

  static const String visibleDaysKey = 'visible_days';
  static const String thresholdCountKey = 'threshold_count';

  static const String languageKey = 'language';

  static const String latKey = 'lat';
  static const String lonKey = 'lon';
  static const String zoneKey = 'zone';

  static const String starsKey = 'star';

  // SAVE
  static Future<void> saveVisibleDays(int days) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(visibleDaysKey, days);
  }

  // READ
  static Future<int> loadVisibleDays() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(visibleDaysKey) ?? AppConstants.defaultVisibleDays;
  }

  
  // SAVE
  static Future<void> saveThresholdCount(int thresholdCount) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(thresholdCountKey, thresholdCount);
  }

  // READ
  static Future<int> loadThresholdCount() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(thresholdCountKey) ?? AppConstants.defaultThresholdCount;
  }

  
  // SAVE
  static Future<void> saveLanguage(String language) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(languageKey, language);
  }

  // READ
  static Future<String> loadLanguage() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(languageKey) ?? AppConstants.defaultLanguage;
  }

  // SAVE
  static Future<void> saveLat(double lat) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(latKey, lat);
  }

  // READ
  static Future<double> loadLat() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(latKey) ?? AppConstants.defaultLat;
  }

  // SAVE
  static Future<void> saveLon(double lon) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(lonKey, lon);
  }

  // READ
  static Future<double> loadLon() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(lonKey) ?? AppConstants.defaultLon;
  }

  // SAVE
  static Future<void> saveZone(String zone) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(zoneKey, zone);
  }

  // READ
  static Future<String> loadZone() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(zoneKey) ?? AppConstants.defaultZone;
  }

  // SAVE
  static Future<void> saveStars(List<String> stars) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(starsKey, stars);
  }

  // READ
  static Future<List<String>> loadStars() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(starsKey) ?? [];
  }
}