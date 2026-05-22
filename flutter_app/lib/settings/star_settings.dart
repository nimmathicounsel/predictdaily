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

import 'package:PredictDaily/models/person.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../localization/app_localization.dart';
import '../services/settings_service.dart';

import '../models/settings_section.dart';

int selectedStar = 0;



final TextEditingController nameController = TextEditingController();

List<String> starsOfPeople = [];

bool starsLoaded = false;

final SettingsSection starSettings = SettingsSection(
  title: 'Birth star',

  bannerColor: AppColors.softPurple,

  children: [
    // StatefulBuilder creates a micro-state localized just to these sliders
    StatefulBuilder(
      builder: (BuildContext context, StateSetter setElementState) {
        return FutureBuilder<List<dynamic>>(
          // Load both values simultaneously from SharedPreferences
          future: Future.wait([SettingsService.loadStars()]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // format name:starIndex
            if (!starsLoaded) {
              starsOfPeople = List<String>.from(snapshot.data![0]);

              starsLoaded = true;
            }

            Future<void> saveStarsOfPeople() async {
              await SettingsService.saveStars(starsOfPeople);
            }

            final List<String> stars = List<String>.from(AppLocalization.getList('stars'));

            return Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Person name',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 16),

                DropdownButton<int>(
                  value: selectedStar,
                  hint: Text("Choose the birth star of the person"),
                  items: stars.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String val = entry.value;

                    return DropdownMenuItem<int>(value: idx, child: Text(val));
                  }).toList(),
                  onChanged: (int? newIndex) {
                    setElementState(() {
                      selectedStar = newIndex!; // Store the selected index
                    });
                    // print("Selected index: $newIndex");
                    // print("Selected value: ${stars[newIndex!]}");
                    // setElementState(() {});

                    // print("selectedStar = $selectedStar newIndex = $newIndex");
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton.icon(
                  label: const Text('Add person'),

                  onPressed: () async {
                    final personName = nameController.text.trim();

                    // if (personName.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text('Name is required'),
                    //       duration: Duration(seconds: 2),
                    //     ),
                    //   );
                    //   return;
                    // }

                    // final entry = '$personName - $stars[$selectedStar]:$selectedStar';
                    final nameAndStar = '$personName:$selectedStar';
                    // print("nameAndStar = $nameAndStar");
                    setElementState(() {
                      starsOfPeople.add(nameAndStar);

                      saveStarsOfPeople();
                      nameController.clear();
                    });
                  },
                ),

                const SizedBox(height: 16),

                // LIST BOX
                SizedBox(
                  height: 200,

                  child: ReorderableListView.builder(
                    itemCount: starsOfPeople.length,

                    onReorder: (oldIndex, newIndex) {
                      setElementState(() {
                        if (newIndex > oldIndex) {
                          newIndex--;
                        }

                        final item = starsOfPeople.removeAt(oldIndex);

                        starsOfPeople.insert(newIndex, item);

                        saveStarsOfPeople();
                        
                      });
                    },

                    itemBuilder: (context, index) {
                      final starOfPerson = starsOfPeople[index];
                      
                      // String banner = StarDecor.uplift(starOfPerson, stars);
                      Person person = Person.fromCombi(starOfPerson);
                      String banner = person.decor();
                      
                      return Card(
                        key: ValueKey(starOfPerson),

                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),

                        child: ListTile(
                          leading: const Icon(Icons.person),

                          trailing: const Icon(Icons.drag_handle),

                          // CUSTOM TITLE
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  banner,

                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              // DELETE ICON
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),

                                onPressed: () {
                                  setElementState(() {
                                    starsOfPeople.removeAt(index);
                                    
                                    saveStarsOfPeople();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ),
  ],
);
