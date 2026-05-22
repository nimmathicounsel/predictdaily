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

// app_constants.dart
class AppConstants {
  static const defaultVisibleDays = 4;
  static const defaultThresholdCount = 5;

  static const defaultLanguage = "English";

  static const defaultZone = "Asia/Kolkata";
  static const defaultLat = 13.0827;
  static const defaultLon = 80.2707;

  // day starting time. server mentions this value
  // static const startHours = 5;

  static const grahaIndicators = [
    1, 0, 2, 0, 0, 0, 2, 2, 1
  ];

  // each row represent graha 
  // each item in the row points to translation word
  static const List<List<int>> wordMatch = [
  [0,1,2,3,4,5,6,7,8],

  [9,10,11,12,13,14,15,16,17],

  [18,11,19,20,21,22,23,24,25,26],

  [27,28,29,30,31,32,33,34],

  [35,36,37,38,39,40,28,41,42],

  [14,43,44,45,28,31,46,15,47,6,39],

  [48,49,50,51,52,53,54,55,26],

  [52,56,57,58,23,50,20,59,60],

  [61,62,63,64,4,65,66,67,68,69],
];
}
    