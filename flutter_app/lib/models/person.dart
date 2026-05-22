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

import 'package:PredictDaily/localization/app_localization.dart';

class Person {
  final String name;
  final int star;

  Person({
    required this.name,
    required this.star,
  });

  factory Person.fromCombi(String combi) {
    final index = combi.lastIndexOf(':');

    if (index == -1) {
      throw ArgumentError(
        "Invalid combi format. Expected 'name:star'",
      );
    }

    final extractedName =
        combi.substring(0, index).trim();

    final extractedStar = int.parse(
      combi.substring(index + 1).trim(),
    );

    return Person(
      name: extractedName,
      star: extractedStar,
    );
  }

  String decor() {
    List<dynamic> stars = AppLocalization.getList("stars");
    return '$name - star ${stars[star]}';
  }

  @override
  String toString() {
    return "$name:$star";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          star == other.star;

  @override
  int get hashCode => name.hashCode ^ star.hashCode;
}