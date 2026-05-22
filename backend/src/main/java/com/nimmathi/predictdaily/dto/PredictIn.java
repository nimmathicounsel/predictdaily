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

package com.nimmathi.predictdaily.dto;

import java.time.LocalDate;
import java.util.List;

import com.nimmathi.predictdaily.model.LocationInfo;

public class PredictIn {
    private LocationInfo locationInfo;
    private List<LocalDate> dates;
    private List<Integer> janmaStars;    

    public LocationInfo getLocationInfo() {
        return locationInfo;
    }

    public void setLocationInfo(LocationInfo locationInfo) {
        this.locationInfo = locationInfo;
    }

    public List<LocalDate> getDates() {
        return dates;
    }

    public void setDates(List<LocalDate> dates) {
        this.dates = dates;
    }

    public List<Integer> getJanmaStars() {
        return janmaStars;
    }

    public void setJanmaStars(List<Integer> janmaStars) {
        this.janmaStars = janmaStars;
    }
}
