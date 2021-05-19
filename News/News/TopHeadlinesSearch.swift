//
//  TopHeadlinesSearch.swift
//  News
//
//  Created by cs3714 on 2/27/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

import SwiftUI

struct TopHeadlinesSearch: View {
    
    //choices for categories
    let newsCategories = ["All","Business","Entertainment","General","Health","Science","Sports","Technology"]
    //choices for sorting
    let newsSortOptions =
        ["Publication Date","Popularity","Relavency"]
    //default cat choice
    @State var selectedNewsCategory = 0
    //default sort choice
    @State var selectedSortOption = 0
    @State var fromDate = Date()
    @State var toDate = Date()
    
    
    
    
    var body: some View {
        
        
        NavigationView {
            
            Form {
                //Category Picker
                Section(header: Text("Select News Category")) {
                    Picker("Pick", selection: $selectedNewsCategory) {
                        ForEach(0 ..< newsCategories.count, id: \.self) {
                            Text(self.newsCategories[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section(header: Text("Select News Date From")) {
                    DatePicker("News Date From", selection: $fromDate,displayedComponents: .date)
                }
                .pickerStyle(WheelPickerStyle())
                
                Section(header: Text("Select News Date To")) {
                    DatePicker("News Date To", selection: $toDate, displayedComponents: .date)
                }
                .pickerStyle(WheelPickerStyle())
                
                //Sort Option Picker
                Section(header: Text("Select News Sort Option")) {
                    Picker("Pick", selection: $selectedSortOption) {
                        ForEach(0 ..< newsSortOptions.count, id: \.self) {
                            Text(self.newsSortOptions[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
               //button to get API data and generate view with top headlines
                Section(header: Text("Show Top News Headlines in USA")) {
                    NavigationLink(destination: searchNewsHeadlines.navigationBarTitle(Text("News Items Obtained"), displayMode: .inline) ) {
                        HStack {
                            Image(systemName: "gear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                }
                
                
                
            }
            .navigationBarTitle(Text("Get Top News Headlines in USA"),displayMode: .inline)
        }   // End of Form
        
    }   // End of NavigationView
    
    
    // fixes format of the different options and passes them to the API
    private var searchNewsHeadlines: some View {
        
        let cat = newsCategories[selectedNewsCategory].lowercased()
        var from = fromDate.description
        var to = toDate.description
        var sort = newsSortOptions[selectedSortOption].lowercased()
        
        if (sort == "publication date"){
            sort = "publishedAt"
        }

        if (from.count > 10){
            from = String(from.prefix(10))
        }
        
        if (to.count > 10){
            to = String(to.prefix(10))
        }
        
        
        obtainTopHeadlinesFromApi(category:  cat, dateFrom: from , dateTo: to, sortBy: sort)
        //returns a list view of the list generated from the API and NewsList
        return AnyView(NewsList(list: listOfAllTopHeadLines))
    }
    
}




struct TopHeadlinesSearch_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadlinesSearch()
    }
}
