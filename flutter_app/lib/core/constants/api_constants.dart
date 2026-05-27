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

// api_constants.dart
class ApiConstants {
  // static const baseUrl = 'http://10.0.2.2:8080';
  // static const baseUrl = 'http://localhost:8080';

  // static const baseUrl = "http://192.168.1.42:8080";

  // static const baseUrl = "https://predictdaily-production.up.railway.app";

  static const baseUrl = "https://pd-api.nimmathi.net";

  
  static const String fetchUrl =
      "$baseUrl/api/predict/v1/fetch";
  static const timeoutSeconds = 30;
}