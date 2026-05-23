import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'app_share.dart';
import 'upi_launcher.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        20,
      ),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.currency_rupee),
                label: const Text('Donate'),

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,

                  elevation: 1.5,

                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),

                onPressed: () async {
                  await UpiLauncher.launchDonation();
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Share App'),

                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,

                  side: BorderSide(
                    color: AppColors.primary
                        .withOpacity(0.3),
                  ),

                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),

                onPressed: () async {
                  await AppShare.shareApp();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}