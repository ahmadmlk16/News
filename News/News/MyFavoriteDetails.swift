//
//  MyFavoriteDetails.swift
//  News
//
//  Created by cs3714 on 2/23/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

 //view for newsItem details already in favorites
// this view does not have a add to favorites option
struct MyFavoriteDetails: View {
    // Input Parameter
    let news: NewsObject
   
    var body: some View {
        
        Form{
            
            Section(header: Text("Source Name")){
                Text(news.sourceName)
            }
            
            Section(header: Text("News Item Image")){
                getImageFromUrl(url: news.urlToImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            
            Section(header: Text("News Item Title")){
                Text(news.title)
            }
            //nav list to news item website
            Section(header: Text("News Item Publisher Website")){
                NavigationLink(destination: WebView(url: news.url)){
                    HStack{
                        Image(systemName: "globe")
                        Text("Publisher Website")
                    }
                    .aspectRatio(contentMode: .fill)
                }
            }
            Section(header: Text("News Item Author")){
                Text(news.author)
            }
            Section(header: Text("News Item Description")){
                Text(news.description)
            }
            
            Section(header: Text("News Item Publication and Time")){
                Text(DateConverter.getDate(stringDate: news.publishedAt))
            }
            
            Section(header: Text("News Item Content")){
                Text(news.content)
            }
            
        }// End of Form
        
    }// End of View
   

}


struct MyFavoriteDetails_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoriteDetails(news: newsStructList[0])
    }
}
