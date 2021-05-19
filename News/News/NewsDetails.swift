//
//  NewsDetails.swift
//  News
//
//  Created by cs3714 on 2/27/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

 //default view for any non favorite news Item
struct NewsDetails: View {
    // Input Parameter
    let news: NewsObject
    
    @EnvironmentObject var userData: UserData
    @State private var showAddedMessage = false
    
    
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
            //clicking this button adds the current newsitem to the user objects favorites list
            Section(header: Text("Add this news item to my favorites list")) {
                                Button(action: {
                                    // Append the country found to userData.countriesList
                                    
                                    self.userData.newsList.append(self.news)
             
                                    // Set the global variable point to the changed list
                                    newsStructList = self.userData.newsList
                                   
                                    self.showAddedMessage = true
                                }) {
                                    Image(systemName: "plus")
                                        .imageScale(.medium)
                                        .font(Font.title.weight(.regular))
                                }
             }
            //navigation list to the newsItem Website
            Section(header: Text("News Item Publisher Website")){
                NavigationLink(destination: WebView(url: news.url)            .navigationBarTitle(Text("News Website"), displayMode: .inline)){
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
            
            
            
            
            
            
            
        }//End of Form
        .alert(isPresented: $showAddedMessage, content: { self.alert })

        
    }
    //Alert Messege when appending to the list is successful
   var alert: Alert {
       Alert(title: Text("News Item Added!"),
             message: Text("This News Item is added to your favorites list"),
             dismissButton: .default(Text("OK")) )
   }
}


struct NewsDetails_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoriteDetails(news: newsStructList[0])
    }
}
