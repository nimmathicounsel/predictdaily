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

import 'package:geolocator/geolocator.dart';

import '../core/constants/app_constants.dart';
import '../services/settings_service.dart';
import '../services/timezone_service.dart';
import '../models/location_data.dart';

class LocationService {

  static Future<LocationData> getCurrentLocation() async {

    bool serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {

      return const LocationData(
        latitude: AppConstants.defaultLat,
        longitude: AppConstants.defaultLon,
      );
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {

      permission =
          await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {

      return const LocationData(
        latitude: AppConstants.defaultLat,
        longitude: AppConstants.defaultLon,
      );
    }

    final position =
        await Geolocator.getCurrentPosition();

    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }


  // save lat, lon and timezone into sharedPref
  static Future<void> saveLocationData(double lat, double lon) async {
    await SettingsService.saveLat(lat);
    await SettingsService.saveLon(lon);

    final zone = TimezoneService.getTimezone(

      latitude: lat,
      longitude: lon,
    );

    await SettingsService.saveZone(zone);
  }
}