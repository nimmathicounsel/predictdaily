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

import 'upi_launcher.dart';

class DonationSection
    extends StatelessWidget {

  const DonationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        const SizedBox(height: 32),

        Container(

          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(

            color: const Color(0xFFFFF8E8),

            borderRadius:
                BorderRadius.circular(20),

            border: Border.all(
              color: const Color(0xFFFFD180),
            ),

            boxShadow: const [

              BoxShadow(

                blurRadius: 8,

                offset: Offset(0, 3),

                color: Color.fromRGBO(
                  0,
                  0,
                  0,
                  0.08,
                ),
              ),
            ],
          ),

          child: Column(

            children: [

              const Icon(

                Icons.favorite,

                color: Colors.red,

                size: 42,
              ),

              const SizedBox(height: 12),

              const Text(

                'Support PredictDaily',

                style: TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(

                'If PredictDaily has been '
                'helpful to you, even a '
                'small contribution of ₹10 '
                'can help us keep the app '
                'running and continue '
                'improving it for everyone.',

                textAlign:
                    TextAlign.center,

                style: TextStyle(

                  height: 1.6,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(

                onTap: () async {

                  await UpiLauncher
                      .launchDonation();
                },

                child: Column(

                  children: [

                    ClipRRect(

                      borderRadius:
                          BorderRadius.circular(
                            16,
                          ),

                      child: Image.asset(

                        'assets/images/'
                        'shanthiSevaUpiQrCode.jpeg',

                        height: 240,
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 20,

                        vertical: 12,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.green,

                        borderRadius:
                            BorderRadius.circular(
                              12,
                            ),
                      ),

                      child: const Text(

                        'Tap QR to Open UPI App',

                        style: TextStyle(

                          color: Colors.white,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}