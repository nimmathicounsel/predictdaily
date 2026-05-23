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

import 'package:PredictDaily/widgets/app_footer.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_html/flutter_html.dart';

import '../widgets/app_header.dart';
import '../widgets/donation_section.dart';

class HtmlContentScreen extends StatefulWidget {
  final String title;

  final String assetPath;

  final bool showDonation;

  // final String? upiUrl;
  final Uri? uri;

  const HtmlContentScreen({
    super.key,

    required this.title,

    required this.assetPath,

    this.showDonation = false,

    // this.upiUrl,
    this.uri,
  });

  @override
  State<HtmlContentScreen> createState() => _HtmlContentScreenState();
}

class _HtmlContentScreenState extends State<HtmlContentScreen> {
  String htmlData = '';
  String title = '';

  @override
  void initState() {
    super.initState();

    loadHtml();
  }

  Future<void> loadHtml() async {
    final data = await rootBundle.loadString(widget.assetPath);

    setState(() {
      title = widget.title;
      htmlData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: title),
      bottomNavigationBar: const AppFooter(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    Html(data: htmlData),

                    if (widget.showDonation) ...[
                      const DonationSection(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
