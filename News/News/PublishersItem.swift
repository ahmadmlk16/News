//
//  PublishersItem.swift
//  News
//
//  Created by cs3714 on 2/28/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

// Each Publisher list Item
struct PublishersItem: View {
    let publisher: NewsPublisherObject
    
    var body: some View {
        HStack {
            Image(publisher.category.capitalized)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .leading)
            
            VStack(alignment: .leading){
                Text(publisher.name)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                Text("News Category: " + publisher.category.capitalized)
                    .font(.callout)
                    .lineLimit(3)
                Text("Publisher Country: " + publisher.country.uppercased())
                    .font(.callout)
                    .multilineTextAlignment(.leading)
            }
        }   // End of HStack
    }
}

struct PublishersItem_Previews: PreviewProvider {
    static var previews: some View {
        PublishersItem(publisher: listOfAllNewsPublishers[0])
    }
}
