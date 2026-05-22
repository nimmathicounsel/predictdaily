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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nimmathi.predictdaily.constants.Const;
import com.nimmathi.predictdaily.dto.PredictIn;
import com.nimmathi.predictdaily.dto.PredictOut;
import com.nimmathi.predictdaily.model.DinaThara;
import com.nimmathi.predictdaily.model.GrahaThara;
import com.nimmathi.predictdaily.model.LocationInfo;

@Service
public class PredictService {
    @Autowired
    private DinaTharaFinder dinaTharaFinder;

    @Autowired
    private GrahaTharaFinder grahaTharaFinder;
    
    public PredictOut predict(PredictIn predictIn) {
        LocationInfo locationInfo = makeup(predictIn.getLocationInfo());

        PredictOut predictOut = new PredictOut();

        try {
            DinaThara dinaThara = dinaTharaFinder.findDinaThara(
                    predictIn.getDates(), locationInfo);
            predictOut.setDinaThara(dinaThara);

            GrahaThara grahaThara = grahaTharaFinder.findGrahaThara(
                    dinaThara, predictIn.getJanmaStars());
            predictOut.setGrahaThara(grahaThara);
        } catch(Exception ex) {
            predictOut.setError(ex.getMessage());
        }

        return predictOut;
    }

    private LocationInfo makeup(LocationInfo locationInfo) {
        Double lat = locationInfo == null || locationInfo.getLat() == null ? 
            Const.DEFAULT_LAT : locationInfo.getLat();
        Double lon = locationInfo == null || locationInfo.getLon() == null ? 
            Const.DEFAULT_LON : locationInfo.getLon();
        String zone = locationInfo == null || locationInfo.getZone() == null || 
                locationInfo.getZone().isEmpty() ? 
            Const.DEFAULT_ZONE : locationInfo.getZone();
        return new LocationInfo(lat, lon, zone);
    }

    
}
