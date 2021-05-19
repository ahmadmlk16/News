//
//  MyFavoritesList.swift
//  News
//
//  Created by cs3714 on 2/23/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct MyFavoritesList: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        NavigationView {
            List {
                // Each newsItems struct has its own unique 'id' used by ForEach
                ForEach(userData.newsList) { aNews in
                    NavigationLink(destination: MyFavoriteDetails(news: aNews)) {
                        NewsItem(news: aNews)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
            .navigationBarTitle(Text("My Favorites"), displayMode: .inline)
           
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton())
           
        }   // End of NavigationView
    }
   
    /*
     -------------------------------
     MARK: - Delete Selected newsItems
     -------------------------------
     */
    /*
     IndexSet:  A collection of unique integer values that represent the indexes of elements in another collection.
     first:     The first integer in self, or nil if self is empty.
     */
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            userData.newsList.remove(at: first)
        }
        // Set the global variable point to the changed list
        newsStructList = userData.newsList
    }
   
    /*
     -----------------------------
     MARK: - Move Selected newsItems
     -----------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
 
        userData.newsList.move(fromOffsets: source, toOffset: destination)
       
        // Set the global variable point to the changed list
        newsStructList = userData.newsList
    }
}
 
 
struct MyFavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoritesList()
            .environmentObject(UserData())
    }
}
 
 
