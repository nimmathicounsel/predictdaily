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
import java.util.HashMap;
import java.util.Map;

public class GrahaThara {
    private Map<Integer, Map<LocalDate, Integer[]>> grahaOfStar = new HashMap<>();

    public void addGrahas(Integer janmaStar, LocalDate date, Integer[] grahas) {
        grahaOfStar.computeIfAbsent(janmaStar, k -> new HashMap<>()).put(date, grahas);
    }

    
    public boolean exist(Integer janmaStar) {
        return grahaOfStar.containsKey(janmaStar);
    }

    public Map<Integer, Map<LocalDate, Integer[]>> getGrahaOfStar() {
        return grahaOfStar;
    }

    public void setGrahaOfStar(Map<Integer, Map<LocalDate, Integer[]>> grahaOfStar) {
        this.grahaOfStar = grahaOfStar;
    }

}
