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

class SettingsSection extends StatelessWidget {
  final String title;
  final Color bannerColor;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.bannerColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // This is the absolute shortest a functional layout build can be.
    // It maps your properties directly to standard Flutter visual components.
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: bannerColor,
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: Text(title, style: const TextStyle(color: Colors.white)),
          ),
          ...children, // Unpacks your sliders directly into the column
        ],
      ),
    );
  }
}
