//
//  DateConverter.swift
//  News
//
//  Created by cs3714 on 2/23/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
//Creates a global class that can be used to convert dates between different required formats

class DateConverter{
 
    static func getDate( stringDate : String) -> String {
        let firstPart = stringDate.prefix(16)
            
             // Convert firstPart substring to String
             let cleanedStringDate = String(firstPart)
             
             // Create an instance of DateFormatter
             let dateFormatter = DateFormatter()
            
             // Set date format and locale
             dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
             dateFormatter.locale = Locale(identifier: "en_US")
             
             // Convert date String to Date struct
             let dateStruct = dateFormatter.date(from: cleanedStringDate)
             
             // Create a new instance of DateFormatter
             let newDateFormatter = DateFormatter()
             
             newDateFormatter.locale = Locale(identifier: "en_US")
             newDateFormatter.dateStyle = .medium    // Jan 18, 2020
             newDateFormatter.timeStyle = .medium    // at 12:26 PM
             
             // Obtain newly formatted Date String as "Jan 18, 2020 at 12:26 PM"
             let dateWithNewFormat = newDateFormatter.string(from: dateStruct!)
        
             return dateWithNewFormat
        
    }
    
    
}
