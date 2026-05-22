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


import java.io.IOException;
import java.util.function.Supplier;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ResourceLoader;
import org.springframework.util.ResourceUtils;

import swisseph.SwissEph;

@Configuration
public class EphemerisConfig {

    private final String ephemerisPath;
    private final ThreadLocal<SwissEph> swissEphTL;

    public EphemerisConfig(
            @Value("${astro.ephemeris.path:#{systemProperties['user.dir'] + '/ephemeris/data'}}")
            // @Value("${systemProperties['user.dir'] + '/ephemeris/data'}") 
            String ephemerisPath, 
            ResourceLoader resourceLoader) throws IOException {

        // Resolve paths like classpath: or file: safely across deployments
        String resolvedPath = ResourceUtils.getURL(resourceLoader.getResource(ephemerisPath).getURI().toString()).getPath();
        this.ephemerisPath = resolvedPath;

        this.swissEphTL = ThreadLocal.withInitial(() -> {
            SwissEph sw = new SwissEph(this.ephemerisPath);
            sw.swe_set_ephe_path(this.ephemerisPath);
            return sw;
        });
    }

    public SwissEph get() {
        return swissEphTL.get();
    }

    @Bean
    public Supplier<SwissEph> swissEphSupplier() {
        return swissEphTL::get;
    }
}


/*
public class EphemerisConfig {
    @Value("${astro.ephemeris.path}")
    private String ephemerisPath;

    private final ThreadLocal<SwissEph> swissEphTL =
        ThreadLocal.withInitial(() -> {
            SwissEph sw = new SwissEph(ephemerisPath);
            sw.swe_set_ephe_path(ephemerisPath);
            return sw;
        });

    public SwissEph get() {
        return swissEphTL.get();
    }

    @Bean
    public Supplier<SwissEph> swissEphSupplier() {
        return () -> swissEphTL.get();
    }

}
*/