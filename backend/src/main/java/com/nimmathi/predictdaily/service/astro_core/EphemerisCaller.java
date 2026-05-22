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

package com.nimmathi.predictdaily.service.astro_core;

import java.time.Instant;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.function.Supplier;

import org.springframework.stereotype.Service;

import com.nimmathi.predictdaily.model.PlanetData;

import swisseph.DblObj;
import swisseph.SweConst;
import swisseph.SweDate;
import swisseph.SwissEph;

@Service
public class EphemerisCaller {

    private static final int SID_METHOD = SweConst.SE_SIDM_LAHIRI;

    private final Supplier<SwissEph> swissEphSupplier;

    public EphemerisCaller(Supplier<SwissEph> swissEphSupplier) {
        this.swissEphSupplier = swissEphSupplier;
    }

    public Instant findSunriseTime(
            Instant utc,
            double lat,
            double lon) {

        SwissEph sw = swissEphSupplier.get();

        ZonedDateTime zdt = utc.atZone(ZoneOffset.UTC);

        double jd = SweDate.getJulDay(
                zdt.getYear(),
                zdt.getMonthValue(),
                zdt.getDayOfMonth(),
                zdt.getHour()
                        + zdt.getMinute() / 60.0
                        + zdt.getSecond() / 3600.0,
                SweDate.SE_GREG_CAL);

        DblObj riseTime =
            new DblObj();

        StringBuffer serr = new StringBuffer(256);

        int result = sw.swe_rise_trans(
                jd,
                SweConst.SE_SUN,
                null,
                SweConst.SEFLG_SWIEPH,
                SweConst.SE_CALC_RISE,
                new double[] {
                        lon,
                        lat,
                        0
                },
                0,
                0,
                riseTime,
                serr);

        if (result < 0) {
            throw new RuntimeException(
                    "Swiss Ephemeris sunrise error: "
                            + serr);
        }

        SweDate riseDate =
            new SweDate(riseTime.val);

        ZonedDateTime sunriseUtc = ZonedDateTime.of(
                riseDate.getYear(),
                riseDate.getMonth(),
                riseDate.getDay(),
                0,
                0,
                0,
                0,
                ZoneOffset.UTC).plusSeconds(
                        (long) (riseDate.getHour()
                                * 3600));

        return sunriseUtc.toInstant();
    }

    public PlanetData getPlanetData(int planet, Instant utc, double lat, double lon) throws RuntimeException {
        SwissEph sw = swissEphSupplier.get();
        int flags = SweConst.SEFLG_SWIEPH | // fastest method, requires data files
                SweConst.SEFLG_SIDEREAL | // sidereal zodiac
                SweConst.SEFLG_NONUT | // will be set automatically for sidereal calculations, if not set here
                SweConst.SEFLG_SPEED; // to determine retrograde vs. direct motion

        double jd = SweDate.getJulDay(
                utc.atZone(ZoneOffset.UTC).getYear(),
                utc.atZone(ZoneOffset.UTC).getMonthValue(),
                utc.atZone(ZoneOffset.UTC).getDayOfMonth(),
                utc.atZone(ZoneOffset.UTC).getHour()
                        + utc.atZone(ZoneOffset.UTC).getMinute() / 60.0
                        + utc.atZone(ZoneOffset.UTC).getSecond() / 3600.0,
                SweDate.SE_GREG_CAL);

        sw.swe_set_sid_mode(SID_METHOD, 0, 0);

        double[] xp = new double[6];
        StringBuffer serr = new StringBuffer(256);

        serr.setLength(0);
        int ret = sw.swe_calc_ut(jd, planet, flags, xp, serr);
        if (ret < 0) {
            throw new RuntimeException("Swiss Ephemeris error: " + serr);
        }

        // pass degree, speed
        PlanetData planetData = new PlanetData(xp[0], xp[3]);

        return planetData;

    }
}
