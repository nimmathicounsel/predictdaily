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

import java.time.LocalDateTime;

public class PlanetData {

    private Double degree;
    private Double speedPerDay;
    private LocalDateTime sunriseTime;
    
    
    public PlanetData(Double degree, Double speedPerDay) {
        this.degree = degree;
        this.speedPerDay = speedPerDay;
    }
    
   
    public Double getDegree() {
        return degree;
    }
    public void setDegree(Double degree) {
        this.degree = degree;
    }
    public Double getSpeedPerDay() {
        return speedPerDay;
    }
    public void setSpeedPerDay(Double speedPerDay) {
        this.speedPerDay = speedPerDay;
    }

    public LocalDateTime getSunriseTime() {
        return sunriseTime;
    }

    public void setSunriseTime(LocalDateTime sunriseTime) {
        this.sunriseTime = sunriseTime;
    }
}
