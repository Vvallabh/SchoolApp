//
//  School.swift
//  19900926-Vishnupriya-NYCSchools
//
//  Created by Vishnupriya on 9/12/18.
//  Copyright © 2018 Sonar. All rights reserved.
//

import UIKit

typealias SchoolList = [[String: String]]

typealias SchoolDetails = [SchoolDetail]

struct SchoolDetail: Codable {
    let dbn, numOfSatTestTakers, satCriticalReadingAvgScore, satMathAvgScore: String
    let satWritingAvgScore, schoolName: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
        case schoolName = "school_name"
    }
}
