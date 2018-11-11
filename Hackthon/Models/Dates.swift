//
//  Dates.swift
//  HajjHackathonIOS
//
//  Created by Abdullah Alhaider on 01/08/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import Foundation

struct Dates: Codable {
    
    let day: String?
    let date: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case day
        case date
        case description
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
    
}

