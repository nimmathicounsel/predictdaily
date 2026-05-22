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

package com.nimmathi.predictdaily.service.main;

import java.time.LocalDate;
import java.util.Objects;

import com.nimmathi.predictdaily.model.LocationInfo;

public class MoonCacheKey {
    private final long roundedLat;
    private final long roundedLon;
    private LocationInfo locationInfo;
    private final LocalDate date;

    public MoonCacheKey(LocationInfo locationInfo, LocalDate date) {
        this.locationInfo = locationInfo;

        // Rounding to the nearest 0.5 degree (multiply by 2, round, keep as long)
        this.roundedLat = Math.round(locationInfo.getLat() * 2.0);
        this.roundedLon = Math.round(locationInfo.getLon() * 2.0);
        this.date = date;
    }

     @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof MoonCacheKey)) return false;
        MoonCacheKey that = (MoonCacheKey) o;
        return roundedLat == that.roundedLat &&
               roundedLon == that.roundedLon &&
               Objects.equals(date, that.date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(roundedLat, roundedLon, date);
    }

    public long getRoundedLat() {
        return roundedLat;
    }

    public long getRoundedLon() {
        return roundedLon;
    }

    public LocationInfo getLocationInfo() {
        return locationInfo;
    }

    public void setLocationInfo(LocationInfo locationInfo) {
        this.locationInfo = locationInfo;
    }

    public LocalDate getDate() {
        return date;
    }

    
}
