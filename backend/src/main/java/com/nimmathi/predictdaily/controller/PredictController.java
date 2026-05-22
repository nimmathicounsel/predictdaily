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

package com.nimmathi.predictdaily.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nimmathi.predictdaily.dto.PredictIn;
import com.nimmathi.predictdaily.dto.PredictOut;
import com.nimmathi.predictdaily.service.main.PredictService;

@RestController
@RequestMapping("/api/predict/v1")
public class PredictController {

    @Autowired
    private PredictService predictService;

    @PostMapping("/fetch")
    public ResponseEntity<PredictOut> predict(@RequestBody PredictIn predictIn) {
        PredictOut predictOut = predictService.predict(predictIn);
        return ResponseEntity.ok(predictOut);
    }
}