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

package com.nimmathi.predictdaily.config;

import jakarta.annotation.PostConstruct;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.nio.file.*;

@Component
public class SwissEphemerisLoader {

    @PostConstruct
    public void init() throws Exception {

        String targetDir =
                System.getProperty("java.io.tmpdir") + "/ephe";

        Files.createDirectories(Paths.get(targetDir));

        PathMatchingResourcePatternResolver resolver =
                new PathMatchingResourcePatternResolver();

        Resource[] resources =
                resolver.getResources("classpath:ephe/*");

        for (Resource resource : resources) {

            String fileName = resource.getFilename();

            if (fileName == null) {
                continue;
            }

            Path targetPath =
                    Paths.get(targetDir, fileName);

            try (InputStream inputStream =
                         resource.getInputStream()) {

                Files.copy(
                        inputStream,
                        targetPath,
                        StandardCopyOption.REPLACE_EXISTING
                );
            }

            // System.out.println(
                    // "Copied ephemeris file: " + fileName);
        }

        System.setProperty("swisseph.path", targetDir);

        // System.out.println(
                // "Swiss ephemeris path: " + targetDir);
    }
}