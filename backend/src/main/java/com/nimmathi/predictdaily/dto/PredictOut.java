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

import com.nimmathi.predictdaily.model.DinaThara;
import com.nimmathi.predictdaily.model.GrahaThara;



public class PredictOut {
    private GrahaThara grahaThara;
    private DinaThara dinaThara;

    private String error;
    
    public GrahaThara getGrahaThara() {
        return grahaThara;
    }
    
    public void setGrahaThara(GrahaThara grahaThara) {
        this.grahaThara = grahaThara;
    }

    public DinaThara getDinaThara() {
        return dinaThara;
    }

    public void setDinaThara(DinaThara dinaThara) {
        this.dinaThara = dinaThara;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}