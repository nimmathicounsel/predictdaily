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