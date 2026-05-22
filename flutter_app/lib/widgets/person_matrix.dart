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

import 'package:flutter/material.dart';

import '../models/prediction_person.dart';
import '../services/settings_service.dart';
import 'block.dart';

class PersonMatrix extends StatelessWidget {
  final PredictionPerson predictionPerson;

  const PersonMatrix({super.key, required this.predictionPerson});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: SettingsService.loadThresholdCount(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final columns = snapshot.data!;

        final blocks = predictionPerson.predictions.values.toList();

        if (blocks.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No prediction data available"),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final spacing = 8.0;

            final totalSpacing = (columns - 1) * spacing;

            final itemWidth = (constraints.maxWidth - totalSpacing) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: blocks.map((block) {
                return SizedBox(
                  width: itemWidth,
                  height: itemWidth,
                  child: Block(block: block),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
