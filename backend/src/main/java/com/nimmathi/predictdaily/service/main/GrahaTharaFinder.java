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

import java.time.LocalDate;
import java.util.List;
import java.util.Map.Entry;

import org.springframework.stereotype.Service;

import com.nimmathi.predictdaily.constants.Const;
import com.nimmathi.predictdaily.model.DinaThara;
import com.nimmathi.predictdaily.model.GrahaThara;
import com.nimmathi.predictdaily.model.StarEnd;

@Service
public class GrahaTharaFinder {

    public GrahaThara findGrahaThara(DinaThara dinaThara, List<Integer> janmaStars) {
        GrahaThara grahaThara = new GrahaThara();

        for(Integer janmaStar : janmaStars) {
            if(grahaThara.exist(janmaStar))
                continue;

            for(Entry<LocalDate, StarEnd> entry : dinaThara.getStarsOfDay().entrySet()) {
                Integer grahas[] = {
                    findGraha(janmaStar, entry.getValue().getDayStars()[0]),
                    findGraha(janmaStar, entry.getValue().getDayStars()[1])
                };
                grahaThara.addGrahas(janmaStar, entry.getKey(), grahas);
            }
        }

        return grahaThara;
    }

    private Integer findGraha(Integer janmaStar, Integer dayStar) {
        int janmaRuler = janmaStar % Const.RULER_POSITION.length;
        int dayRuler = dayStar % Const.RULER_POSITION.length;

        for(int i = 0; i < Const.RULER_POSITION.length; i++) {
            if((Const.RULER_POSITION[i] + janmaRuler) % Const.RULER_POSITION.length == dayRuler)
                return i;
        }

        // control shouldn't reach here. returning Surya for exceptional case
        return 0;
    }

}
