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

import 'package:share_plus/share_plus.dart';

class AppShare {

  static Future<void> shareApp() async {

    const androidUrl =

      'https://play.google.com/store/apps/details?id=net.nimmathi.predictdaily';

    const iosUrl =

      'https://apps.apple.com/app/idXXXXXXXX';

    final text =

      'I have been using PredictDaily and found the predictions quite accurate.\n\n'
'Try it yourself:\n\n'

      'Android:\n$androidUrl\n\n';

      // 'iPhone:\n$iosUrl';

    await Share.share(text);
  }
}