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

import 'package:PredictDaily/screens/license_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';

import 'app_routes.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );

      case AppRoutes.about:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );

      case AppRoutes.license:
        return MaterialPageRoute(
          builder: (_) => const LicenseScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}