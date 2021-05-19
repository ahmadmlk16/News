//
//  NewsItem.swift
//  News
//
//  Created by cs3714 on 2/27/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

struct NewsItem: View {
        let news: NewsObject
    
    var body: some View {
               HStack {
                //generates the image of the news item
            getImageFromUrl(url: news.urlToImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0, height: 100.0)
            
                VStack(alignment: .leading){
            Text(news.sourceName)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
            Text(news.title)
                    .font(.callout)
                    .lineLimit(3)
                    Text(DateConverter.getDate(stringDate: news.publishedAt))
                .font(.callout)
                .multilineTextAlignment(.leading)
                }
        }   // End of HStack
    }
}

struct NewsItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsItem(news: newsStructList[0])
    }
}
