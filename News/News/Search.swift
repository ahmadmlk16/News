//
//  Search.swift
//  News
//
//  Created by cs3714 on 2/27/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI


struct Search: View {
    //end point options
    let newsApiEndPoints =
        ["Top Headlines","Everything"]
    //sort options
    let newsSortOptions =
        ["Publication Date","Popularity"]
    
    //default values
    @State var selectedNewsApiEndPoimts = 0
    @State var fromDate = Date()
    @State var toDate = Date()
    @State var selectedSortOption = 0
    @State private var searchTextFieldValue = ""
    @State private var searchStringEntered = ""
    
    
    var body: some View {
        NavigationView{
            Form{
                
                //Picker for endpoint
                Section(header: Text("Select News API Endpoint")) {
                    Picker("Pick", selection: $selectedNewsApiEndPoimts) {
                        ForEach(0 ..< newsApiEndPoints.count, id: \.self) {
                            Text(self.newsApiEndPoints[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select News Date From")) {
                    DatePicker("News Date From", selection: $fromDate,displayedComponents: .date)
                }
                .pickerStyle(WheelPickerStyle())
                
                Section(header: Text("Select News Date To")) {
                    DatePicker("News Date To", selection: $toDate, displayedComponents: .date)
                }
                .pickerStyle(WheelPickerStyle())
                // Sort Option picker
                Section(header: Text("Select News Sort Option")) {
                    Picker("Pick", selection: $selectedSortOption) {
                        ForEach(0 ..< newsSortOptions.count, id: \.self) {
                            Text(self.newsSortOptions[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                //String search section
                Section(header:
                    Text("Enter search string and then press the Return key")
                ) {
                    HStack {
                        
                        TextField("Enter Search String", text: $searchTextFieldValue,
                                  onCommit: {
                                    // Record entered value after Return key is pressed
                                    self.searchStringEntered = self.searchTextFieldValue
                        }
                        )   // End of TextField
                            
                            .keyboardType(.default)
                            .autocapitalization(.allCharacters)
                            .disableAutocorrection(true)
                        
                        // Button to clear the text field
                        Button(action: {
                            self.searchTextFieldValue = ""
                            self.searchStringEntered = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                    
                }
                //This part only pops up when the String search is not empty.
                // This button allows to pass the varibles to the API
                if !searchStringEntered.isEmpty {
                    Section(header: Text("Search Country")) {
                        NavigationLink(destination: searchNewsHeadlines) {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                }
                
                
            }
            .navigationBarTitle(Text("Search News in English"),displayMode: .inline)
        }
    }
   // fixes format of the different options and passes them to the API
    private var searchNewsHeadlines: some View {
       
        var end = newsApiEndPoints[selectedNewsApiEndPoimts].lowercased()
        var from = fromDate.description
        var to = toDate.description
        var sort = newsSortOptions[selectedSortOption].lowercased()
        let search = searchStringEntered.lowercased().trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "+")
        
        if (search.isEmpty){
            return AnyView(errorMessage)
        }
        
        if (sort == "publication date"){
            sort = "publishedAt"
        }
        if (end == "top headlines"){
            end = "topheadlines"
        }

        if (from.count > 10){
            from = String(from.prefix(10))
        }
        
        if (to.count > 10){
            to = String(to.prefix(10))
        }
        
        
        
       obtainSearchNewsFromApi(endpoint: end, dateFrom: from, dateTo: to, sortBy: sort, searchQuery: search)
        //returns a list view of the list generated from the API and NewsList
        return AnyView(NewsList(list: listOfSearchNews))
    }
    //This error message pops up if white space is passed into the search string
    var errorMessage: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
            Text("Please enter a valid search query!")
                .font(.body)    // Needed for the text to wrap around
                .padding()
                .multilineTextAlignment(.center)
        }
    }
    
    
}




struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}


