//
//  NewsPublisherObject.swift
//  News
//
//  Created by cs3714 on 2/27/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation

// News Publisher Object with the folllowing values
struct NewsPublisherObject: Hashable, Codable, Identifiable {
   
    var id: UUID      // Storage Type: String, Use Type (format): UUID
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String
}
