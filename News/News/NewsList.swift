//
//  NewsList.swift
//  News
//
//  Created by cs3714 on 2/27/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 


struct NewsList: View {
   

    var list : [NewsObject]
 
    var body: some View {
 
            List {
                // Each Country struct has its own unique 'id' used by ForEach
                ForEach(list) { aNews in
                    NavigationLink(destination: NewsDetails(news: aNews)        .navigationBarTitle(Text("News Item Details"), displayMode: .inline)) {
                        NewsItem(news: aNews)
                    }
                }
            }   // End of List
         
     
         
    }
   

}
 
 
struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList(list: listOfAllTopHeadLines)
 
    }
}
