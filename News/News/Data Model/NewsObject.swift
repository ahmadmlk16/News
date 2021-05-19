//
//  NewsObject.swift
//  News
//
//  Created by cs3714 on 2/23/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
// News Item Object with the folllowing values
struct NewsObject: Hashable, Codable, Identifiable {
   
    var id: UUID     // Storage Type: String, Use Type (format): UUID
    var sourceName: String
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
}
 
