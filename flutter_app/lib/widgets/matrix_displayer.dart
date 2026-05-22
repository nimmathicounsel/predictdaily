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
import 'package:PredictDaily/services/settings_service.dart';
import 'package:flutter/material.dart';

import '../models/location_info.dart';
import '../models/person.dart';
import '../models/prediction_matrix.dart';
import '../services/bridge_service.dart';
import 'date_processor.dart';
import 'person_matrix.dart';

class MatrixDisplayer extends StatefulWidget {
  final List<Person> persons;
  final BridgeService bridgeService;
  final LocationInfo locationInfo;

  const MatrixDisplayer({
    super.key,
    required this.persons,
    required this.bridgeService,
    required this.locationInfo,
  });

  @override
  State<MatrixDisplayer> createState() => _MatrixDisplayerState();
}

class _MatrixDisplayerState extends State<MatrixDisplayer> {
  late DateTime _selectedDate;
  
  PredictionMatrix? _matrix;

  bool _loading = false;

  String? _error;

  @override
  void initState() {
    super.initState();

    _selectedDate = _normalizeDate(DateTime.now());

    _loadMatrix();
  }

  Future<void> _loadMatrix() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final visibleDays = await SettingsService.loadVisibleDays();

      final dates = List.generate(
        visibleDays,
        (index) => _normalizeDate(_selectedDate.add(Duration(days: index))),
      );

      final matrix = await widget.bridgeService.fetchPredictionMatrix(
        persons: widget.persons,
        dates: dates,
        locationInfo: widget.locationInfo,
      );

      setState(() {
        _matrix = matrix;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> setDateInProcessor(DateTime date) async {
    final normalized = _normalizeDate(date);

    setState(() {
      _selectedDate = normalized;
    });

    await _loadMatrix();
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateProcessor(
          selectedDate: _selectedDate,
          onDateChanged: setDateInProcessor,
        ),

        const SizedBox(
                        height: 12,
                      ),

        Text("Tap a date below to see how the day unfolds.",
        style: TextStyle(fontSize: 16),),

        const SizedBox(
                        height: 12,
                      ),


        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(_error!, style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    if (_matrix == null) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      itemCount: widget.persons.length,
      itemBuilder: (context, index) {
        final person = widget.persons[index];

        final predictionPerson = _matrix!.persons[person];

        return Card(
          color: AppColors.softWhite,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ExpansionTile(
            title: Text(person.decor(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            initiallyExpanded: index == 0,
            children: [
              if (predictionPerson != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PersonMatrix(predictionPerson: predictionPerson),
                ),
            ],
          ),
        );
      },
    );
  }
}
