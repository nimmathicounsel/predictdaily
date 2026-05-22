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

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import com.nimmathi.predictdaily.constants.Const;
import com.nimmathi.predictdaily.model.DinaThara;
import com.nimmathi.predictdaily.model.LocationInfo;
import com.nimmathi.predictdaily.model.PlanetData;
import com.nimmathi.predictdaily.service.astro_core.EphemerisCaller;
import com.nimmathi.predictdaily.util.DateHandler;

import swisseph.SweConst;

@Service
public class DinaTharaFinder {

    @Autowired
    private EphemerisCaller epCaller;

    private final LoadingCache<MoonCacheKey, PlanetData> moonCache = Caffeine.newBuilder()
            .maximumSize(Const.CACHE_SIZE)
            .expireAfterWrite(Const.STORAGE_DAYS, TimeUnit.DAYS) // Automatically evicts entries n days after creation
            .build(key -> loadMoonData(key.getLocationInfo(), key.getDate()));

    public DinaThara findDinaThara(List<LocalDate> dates, LocationInfo locationInfo) {
        DinaThara dinaThara = new DinaThara();

        for (LocalDate date : dates) {

            PlanetData moonData = getMoonData(locationInfo, date);

            int dayStar = findDayStar(moonData);
            Long starEndTime = findStarEndTime(dayStar, moonData);

            dinaThara.addDayStar(date, dayStar, starEndTime, moonData.getSunriseTime());
        }

        return dinaThara;
    }

    private LocalDateTime findSunriseTime(LocationInfo locationInfo, LocalDate date) {
        LocalDateTime midnightDate = LocalDateTime.of(date, LocalTime.of(0, 0, 0, 0));
        Instant instant = epCaller.findSunriseTime(DateHandler.findInstant(midnightDate, locationInfo.getZone()),
                locationInfo.getLat(), locationInfo.getLon());

        Instant sunriseInstant = epCaller.findSunriseTime(instant, locationInfo.getLat(), locationInfo.getLon());

        ZoneId zoneId = ZoneId.of(locationInfo.getZone());

        LocalDateTime localSunrise = LocalDateTime.ofInstant(
                sunriseInstant,
                zoneId);

        return localSunrise;
    }

    public PlanetData getMoonData(LocationInfo locationInfo, LocalDate date) {
        // 1. Generate the optimized, shared key
        MoonCacheKey key = new MoonCacheKey(locationInfo, date);

        try {
            // 2. Caffeine looks up the shared key
            // If missing, it uses the specific user's location to fetch and cache it
            return moonCache.get(key);
        } catch (Exception e) {
            System.err.println("Error loading moon data: " + e.getMessage());
            throw e;
        }
    }

    // This remains your original loading logic
    private PlanetData loadMoonData(LocationInfo locationInfo, LocalDate date) {

        LocalDateTime sunriseTime = findSunriseTime(locationInfo, date);

        PlanetData planetData = epCaller.getPlanetData(
                SweConst.SE_MOON,
                DateHandler.findInstant(sunriseTime, locationInfo.getZone()),
                locationInfo.getLat(),
                locationInfo.getLon());

        planetData.setSunriseTime(sunriseTime);

        return planetData;
    }

    /*
     * private PlanetData getMoonData(LocationInfo locationInfo, LocalDate date) {
     * PlanetData moonData = epCaller.getPlanetData(
     * SweConst.SE_MOON,
     * DateHandler.findInstant(date, locationInfo.getZone()),
     * locationInfo.getLat(),
     * locationInfo.getLon());
     * return moonData;
     * }
     */

    private Long findStarEndTime(int star, PlanetData moonData) {
        double normalizedLon = (moonData.getDegree() % 360.0 + 360.0) % 360.0;
        double startDegree = star * Const.NAKSHATRA_SPAN;
        double endDegree = startDegree + Const.NAKSHATRA_SPAN;

        double degreesRemaining = endDegree - normalizedLon;

        double moonSpeedPerHour = moonData.getSpeedPerDay() / 24.0;

        Double hoursRemaining = degreesRemaining / moonSpeedPerHour;
        Long minutesRemaining = (long) (hoursRemaining * 60);
        // long secondsRemaining = (long) (hoursRemaining * 3600);

        // // hardcoded to indicate start of the day
        // LocalTime time = LocalTime.of(0, 0, 0, 0);
        // time = time.plus(secondsRemaining, ChronoUnit.SECONDS);

        return minutesRemaining;
    }

    private int findDayStar(PlanetData moonData) {
        double normalizedLon = (moonData.getDegree() % 360.0 + 360.0) % 360.0;

        int star = (int) (normalizedLon / Const.NAKSHATRA_SPAN);

        return star;
    }
}