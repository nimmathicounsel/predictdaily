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

import 'package:flutter/services.dart';

class LangfilenamesExtractor {
  

static Future<List<String>> getLanguageFiles() async {
  // Load the manifest of all assets
  final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  
  // Get all asset keys (paths)
  final List<String> assets = assetManifest.listAssets();

  // Filter for JSON files in 'assets/lang/' and remove the extension
  return assets
      .where((String key) => key.startsWith('assets/lang/') && key.endsWith('.json'))
      .map((String key) {
        // Get just the filename (e.g., 'en' from 'assets/lang/en.json')
        return key.split('/').last.replaceAll('.json', '');
      })
      .toList();
}

}