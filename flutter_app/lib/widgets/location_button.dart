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

import '../services/location_service.dart';

class LocationButton extends StatefulWidget {
  const LocationButton({super.key});

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  String locationText = 'Location not loaded';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.location_on),

      label: const Text('Get Current Location'),

      onPressed: () async {
        final location = await LocationService.getCurrentLocation();

        setState(() {
          locationText =
              'Lat: ${location.latitude}, '
              'Lon: ${location.longitude}';
        });

        _showLocationDialog(context, location.latitude, location.longitude);
      },
    );
  }

  void _showLocationDialog(BuildContext context, double lat, double lon) {
    final latController = TextEditingController(text: lat.toString());

    final lonController = TextEditingController(text: lon.toString());

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Current Location'),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: latController,
                decoration: const InputDecoration(labelText: 'Latitude'),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: lonController,
                decoration: const InputDecoration(labelText: 'Longitude'),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                // Parse the updated string values from the controllers back to doubles
                final updatedLat = double.tryParse(latController.text) ?? lat;
                final updatedLon = double.tryParse(lonController.text) ?? lon;

                LocationService.saveLocationData(updatedLat, updatedLon);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
