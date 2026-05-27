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

class Decor {
  static String uplift(String str, List<String> stars) {
    // No colon
    if (!str.contains(':')) {
      return str;
    }

    // Find last colon
    final lastColon = str.lastIndexOf(':');

    // Invalid position
    if (lastColon == -1 || lastColon == str.length - 1) {
      return str;
    }

    final part1 = str.substring(0, lastColon);

    final part2 = str.substring(lastColon + 1);

    // Check integer
    final starIndex = int.tryParse(part2);

    if (starIndex == null) {
      return str;
    }

    // Bounds check
    if (starIndex < 0 || starIndex >= stars.length) {
      return str;
    }

    return '$part1 - star ${stars[starIndex]}';
  }

  static String dateToStr(DateTime date) {
    const dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    return "${dayNames[date.weekday - 1]}, "
        "${date.day.toString().padLeft(2, '0')}-"
        "${monthNames[date.month - 1]}-"
        "${date.year}";
  }

  static String timeToStr(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:"
        "${dt.minute.toString().padLeft(2, '0')}";
  }
}
