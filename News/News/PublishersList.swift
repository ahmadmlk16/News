//
//  PublishersList.swift
//  News
//
//  Created by cs3714 on 2/28/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

struct PublishersList: View {
   
   
    var body: some View {
        NavigationView {
            List {
                // Each publisher struct has its own unique 'id' used by ForEach
                ForEach(listOfAllNewsPublishers) { aPublisher in
                    NavigationLink(destination: PublishersDetails(publisher: aPublisher)) {
                        PublishersItem(publisher: aPublisher)
                    }
                }

               
            }   // End of List
            .navigationBarTitle(Text("News Publishers"), displayMode: .inline)
      
        }   // End of NavigationView
    }
   

}

struct PublishersList_Previews: PreviewProvider {
    static var previews: some View {
        PublishersList()
    }
}
