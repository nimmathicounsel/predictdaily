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

import 'package:PredictDaily/core/constants/app_colors.dart';
import 'package:PredictDaily/models/location_info.dart';
import 'package:PredictDaily/models/person.dart';
import 'package:PredictDaily/routes/app_routes.dart';
import 'package:PredictDaily/services/api_service.dart';
import 'package:PredictDaily/services/bridge_service.dart';
import 'package:PredictDaily/services/settings_service.dart';
import 'package:PredictDaily/utils/person_convertor.dart';
import 'package:PredictDaily/widgets/app_footer.dart';
import 'package:PredictDaily/widgets/matrix_displayer.dart';
import 'package:flutter/material.dart';

import '../widgets/app_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Home"),
      bottomNavigationBar: const AppFooter(),
      backgroundColor: AppColors.mainBackground,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadInitialData(), // Fetches the data asynchronously
        builder: (context, snapshot) {
          // 1. Handle Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Handle Error State
          if (snapshot.hasError) {
            return Center(child: Text("Error loading data: ${snapshot.error}"));
          }

          // 3. Extract data
          final data = snapshot.data ?? {};

          final starsOfPerson = data["starsOfPerson"] as List<String>? ?? [];

          final locationInfo = data["locationInfo"] as LocationInfo;

          List<Person> persons = PersonConvertor.convert(starsOfPerson);

          // 4. Handle Empty State
          if (starsOfPerson.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(
                        text: "Please choose your birth star in the ",
                        style: const TextStyle(
                          fontSize: 18, // Added font size for the regular text
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () async {
                            // Wait for settings to close, then trigger a redraw of this screen
                            await Navigator.pushNamed(
                              context,
                              AppRoutes.settings,
                            );
                            (context as Element).markNeedsBuild();
                          },
                          child: const Text(
                            "Settings page",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                ),
              ),
            );
          }

          // 5. Handle Success State (Data is present)
          return MatrixDisplayer(
            persons: persons,
            bridgeService: BridgeService(apiService: ApiService()),
            locationInfo: locationInfo,
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _loadInitialData() async {
    final stars = await SettingsService.loadStars();

    final lat = await SettingsService.loadLat();

    final lon = await SettingsService.loadLon();

    final zone = await SettingsService.loadZone();

    return {
      "starsOfPerson": stars,

      "locationInfo": LocationInfo(lat: lat, lon: lon, zone: zone),
    };
  }
}
