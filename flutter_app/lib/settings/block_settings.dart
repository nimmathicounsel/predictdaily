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
import '../core/constants/app_colors.dart';
import '../services/settings_service.dart'; // Adjust path
import '../models/settings_section.dart'; // Adjust path

// Keep the exact class type the parent list expects
final SettingsSection blockSettings = SettingsSection(
  title: 'Block arrangement',
  bannerColor: AppColors.softAmber,
  children: [
    // StatefulBuilder creates a micro-state localized just to these sliders
    StatefulBuilder(
      builder: (BuildContext context, StateSetter setElementState) {
        return FutureBuilder<List<int>>(
          // Load both values simultaneously from SharedPreferences
          future: Future.wait([
            SettingsService.loadVisibleDays(),
            SettingsService.loadThresholdCount(),
          ]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final double visibleDays = snapshot.data![0].toDouble();
            final double thresholdCount = snapshot.data![1].toDouble();

            return Column(
              children: [
                Text('Visible Days: ${visibleDays.toInt()}'),
                Slider(
                  value: visibleDays,
                  min: 1, max: 31, divisions: 30,
                  onChanged: (double newValue) async {
                    await SettingsService.saveVisibleDays(newValue.toInt());
                    setElementState(() {}); // Forces the inner block to rebuild and reload preference
                  },
                ),
                const SizedBox(height: 16),
                Text('Days Per Row: ${thresholdCount.toInt()}'),
                Slider(
                  value: thresholdCount,
                  min: 1, max: 31, divisions: 30,
                  onChanged: (double newValue) async {
                    await SettingsService.saveThresholdCount(newValue.toInt());
                    setElementState(() {}); // Forces the inner block to rebuild and reload preference
                  },
                ),
              ],
            );
          },
        );
      },
    ),
  ],
);
