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

package com.nimmathi.predictdaily.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

public class DinaThara {
    private Map<LocalDate, StarEnd> starsOfDay = new HashMap<>();

    public void addDayStar(LocalDate date, Integer dayStar1, Long dayStarEndTime, LocalDateTime sunriseTime) {
        StarEnd starEnd = new StarEnd();
        starEnd.setDayStars(new Integer[]{dayStar1, Star.nextStar(dayStar1)});
        starEnd.setDayStarEndTime(dayStarEndTime);
        starEnd.setSunriseTime(sunriseTime);
        starsOfDay.put(date, starEnd);
    }

    public Map<LocalDate, StarEnd> getStarsOfDay() {
        return starsOfDay;
    }

    public void setStarsOfDay(Map<LocalDate, StarEnd> starsOfDay) {
        this.starsOfDay = starsOfDay;
    }
}
