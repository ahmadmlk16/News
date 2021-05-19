//
//  PublishersDetails.swift
//  News
//
//  Created by cs3714 on 2/28/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
// Publisher Item Details
struct PublishersDetails: View {
    // Input Parameter
    let publisher: NewsPublisherObject
    
    var body: some View {
        
        Form{
            
            Section(header: Text("Publisher Name")){
                Text(publisher.name)
            }
            
            Section(header: Text("Publisher Category")){
                HStack {
                    Image(publisher.category.capitalized)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .leading)
                    Text(publisher.category.capitalized + " News")
                }
            }
            
            Section(header: Text("Publisher Description")){
                Text(publisher.description)
            }
            // Nav link to publishers website
            Section(header: Text("Publisher Website")){
                NavigationLink(destination: WebView(url: publisher.url).navigationBarTitle("Publisher Website")){
                    HStack{
                        Image(systemName: "globe")
                        Text("Publisher Website")
                    }
                       
                    .aspectRatio(contentMode: .fill)
                }
            
            }
            
            Section(header: Text("Publisher Country")){
                Text(publisher.country.uppercased())
            
            }
            
        }
        .navigationBarTitle("Publisher Details")
        
    }
    
    
}


struct PublishersDetails_Previews: PreviewProvider {
    static var previews: some View {
        PublishersDetails(publisher: listOfAllNewsPublishers[0])
    }
}
