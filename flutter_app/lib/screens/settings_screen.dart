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
import 'package:PredictDaily/routes/app_routes.dart';
import 'package:PredictDaily/widgets/app_footer.dart';
import 'package:flutter/material.dart';
import '../settings/block_settings.dart';

import '../models/settings_section.dart';

import '../settings/star_settings.dart';
import '../settings/location_settings.dart';
import '../settings/language_settings.dart';
// import '../settings/privacy_settings.dart';
// import '../settings/appearance_settings.dart';

import '../widgets/app_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SettingsSection> sections = [
      starSettings,
      languageSettings,
      locationSettings,
      blockSettings,
    ];

    return Scaffold(
      appBar: const AppHeader(title: "Settings"),
      bottomNavigationBar: const AppFooter(),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
  padding: const EdgeInsets.fromLTRB(
    16,
    16,
    16,
    4,
  ),

  child: SizedBox(
    width: double.infinity,

    child: ElevatedButton.icon(
      icon: const Icon(Icons.home),

      label: const Text(
        "Back to Home",
      ),

      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,

        elevation: 1.5,

        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),
      ),

      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      },
    ),
  ),
),

            Expanded(
              child: ListView.builder(
                itemCount: sections.length,

                itemBuilder: (context, index) {
                  final section = sections[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),

                    child: ExpansionTile(
                      initiallyExpanded: index == 0 && starsOfPeople.isEmpty,
                      title: Text(
                        section.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      backgroundColor: AppColors.softWhite,

                      // backgroundColor: section.bannerColor.withOpacity(0.18),
                      collapsedBackgroundColor: section.bannerColor,

                      children: section.children,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
