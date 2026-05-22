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

import 'package:PredictDaily/utils/decor.dart';
import 'package:flutter/material.dart';

import '../services/settings_service.dart';

class DateProcessor extends StatelessWidget {
  final DateTime selectedDate;

  final ValueChanged<DateTime>
      onDateChanged;

  const DateProcessor({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  Future<void> _moveLeft() async {
    final visibleDays =
        await SettingsService
            .loadVisibleDays();

    final newDate =
        selectedDate.subtract(
      Duration(days: visibleDays),
    );

    onDateChanged(
      _normalizeDate(newDate),
    );
  }

  Future<void> _moveRight() async {
    final visibleDays =
        await SettingsService
            .loadVisibleDays();

    final newDate = selectedDate.add(
      Duration(days: visibleDays),
    );

    onDateChanged(
      _normalizeDate(newDate),
    );
  }

  Future<void> _pickDate(
    BuildContext context,
  ) async {
    final picked =
        await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      onDateChanged(
        _normalizeDate(picked),
      );
    }
  }

  void _goToToday() {
    onDateChanged(
      _normalizeDate(
        DateTime.now(),
      ),
    );
  }

  DateTime _normalizeDate(
    DateTime date,
  ) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  String _formatDate(
    DateTime date,
  ) {
    return Decor.dateToStr(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            onPressed: _moveLeft,
            icon: const Icon(
              Icons.chevron_left,
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () =>
                  _pickDate(context),
              borderRadius:
                  BorderRadius.circular(
                8,
              ),
              child: Container(
                // color: AppColors.softWhite,
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration:
                    BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(8),
                ),
                child: Text(
                  _formatDate(
                    selectedDate,
                  ),
                  textAlign:
                      TextAlign.center,
                ),
              ),
            ),
          ),

          IconButton(
            onPressed: _moveRight,
            icon: const Icon(
              Icons.chevron_right,
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton(
            onPressed: _goToToday,
            child: const Text(
              "Today",
            ),
          ),
        ],
      ),
    );
  }
}