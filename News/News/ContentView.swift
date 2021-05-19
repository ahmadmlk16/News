//
//  ContentView.swift
//  News
//
//  Created by cs3714 on 2/23/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            MyFavoritesList()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("My Favorites")
            }
            TopHeadlinesSearch()
                .tabItem {
                    Image(systemName: "doc.richtext")
                    Text("Top Headlines")
            }
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
            PublishersList()
                    .tabItem {
                        Image(systemName: "person.2.square.stack.fill")
                        Text("Publishers")
                }
            
                
                
                
                
                
                // End of TabView
                .font(.headline)
                .imageScale(.medium)
                .font(Font.title.weight(.regular))
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(UserData())
        }
}
}
