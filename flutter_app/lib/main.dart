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

import 'package:PredictDaily/cache/entities/prediction_block_cache_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './localization/app_localization.dart';
import './services/settings_service.dart';

import 'routes/app_routes.dart';
import 'routes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String language = await SettingsService.loadLanguage();
  await AppLocalization.load(language);

  await Hive.initFlutter();

  Hive.registerAdapter(PredictionBlockCacheEntityAdapter());

  await Hive.deleteBoxFromDisk(
  "prediction_cache",
);


await Hive.openBox<
    PredictionBlockCacheEntity>(
  "prediction_cache",
);

  runApp(const PredictDailyApp());
}

class PredictDailyApp extends StatelessWidget {
  const PredictDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'PredictDaily',

      initialRoute: AppRoutes.home,

      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
