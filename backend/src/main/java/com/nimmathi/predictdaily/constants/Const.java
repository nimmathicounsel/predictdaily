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

package com.nimmathi.predictdaily.constants;

public class Const {
    public static final int NUM_OF_STARS = 27;

    public static final int[] RULER_POSITION = {
            3, 7, 2, 6, 1, 5, 0, 4, 8
    };

    public final static Double NAKSHATRA_SPAN = 360.0 / NUM_OF_STARS;

    public static final String DEFAULT_ZONE = "Asia/Kolkata";
    public static final Double DEFAULT_LAT = 13.0827;
    public static final Double DEFAULT_LON = 80.2707;

    // number of dates stored in the cache
    // the dates + rounded lat is used as cache key
    public static final long CACHE_SIZE = 5000;

    // number of days to keep the data in cache
    public static final long STORAGE_DAYS = 3;

    // when is the day starting? assuming 5am
    // public static final int START_HOUR = 5;
}
