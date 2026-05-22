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

import 'package:PredictDaily/core/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

import '../core/constants/app_strings.dart';

import '../routes/app_routes.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;

  const AppHeader({super.key, this.title, this.showBackButton = true});

  @override
  Size get preferredSize => const Size.fromHeight(UiConstants.headerHeight);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values
    final bool isMobile = screenWidth < 600;
    final double iconSize = isMobile ? 22 : 28;
    final double appNameSize = isMobile ? 22 : 30;
    final double titleSize = isMobile ? 14 : 18;
    // final double horizontalPadding = isMobile ? 8 : 20;
    // final double topPadding = isMobile ? 45 : 60;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),

      alignment: Alignment.centerLeft,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row
          Row(
            children: [
              // Back Button
              if (showBackButton)
                IconButton(
                  iconSize: iconSize,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

              const Spacer(),

              _headerIcon(
                context,
                Icons.home,
                iconSize,
                AppRoutes.home,
                AppColors.primary,
              ),

              _headerIcon(
                context,
                Icons.settings,
                iconSize,
                AppRoutes.settings,
                // AppColors.secondary,
                AppColors.primary,
              ),

              _headerIcon(
                context,
                Icons.help_outline,
                iconSize,
                AppRoutes.about,
                // AppColors.boldGreen,
                AppColors.primary,
              ),

              _headerIcon(
                context,
                Icons.description_outlined,
                iconSize,
                AppRoutes.license,
                // AppColors.boldBlue,
                AppColors.primary,
              ),

              // IconButton(
              //   iconSize: iconSize,
              //   icon: const Icon(Icons.description_outlined),
              //   color: AppColors.boldBlue,
              //   onPressed: () {
              //     showLicensePage(context: context);
              //   },
              // ),
            ],
          ),

          const SizedBox(height: 8),

          // App Name
          Padding(
            padding: EdgeInsets.only(left: showBackButton ? 12 : 0),
            child: Text(
              AppStrings.appName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: appNameSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                color: Colors.black87,
              ),
            ),
          ),

          // Optional Page Title
          if (title != null)
            Padding(
              padding: EdgeInsets.only(left: showBackButton ? 12 : 0, top: 4),
              child: Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: titleSize,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _headerIcon(
    BuildContext context,
    IconData icon,
    double size,
    String route,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: size,
        icon: Icon(icon),
        color: color,
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
