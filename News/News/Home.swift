//
//  Home.swift
//  News
//
//  Created by cs3714 on 2/23/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct Home: View {
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    var body: some View {
 
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Welcome")
                   //images of the different News companies
                    Image("photo\(userData.imageNumber + 1)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 10)
                        .padding(.top, 30)
                        .padding(.bottom, 5)
                   
                    HStack {
                        Button(action: {    // Button 1
                            self.userData.imageNumber = 0
                        }) {
                            self.imageForButton(buttonNumber: 0)
                            }
                        Button(action: {    // Button 2
                            self.userData.imageNumber = 1
                        }) {
                            self.imageForButton(buttonNumber: 1)
                            }
                        Button(action: {    // Button 3
                            self.userData.imageNumber = 2
                        }) {
                            self.imageForButton(buttonNumber: 2)
                            }
                        Button(action: {    // Button 4
                            self.userData.imageNumber = 3
                        }) {
                            self.imageForButton(buttonNumber: 3)
                            }
                        Button(action: {    // Button 5
                            self.userData.imageNumber = 4
                        }) {
                            self.imageForButton(buttonNumber: 4)
                            }
                        Button(action: {    // Button 6
                            self.userData.imageNumber = 5
                        }) {
                            self.imageForButton(buttonNumber: 5)
                            }
                        Button(action: {    // Button 7
                            self.userData.imageNumber = 6
                        }) {
                            self.imageForButton(buttonNumber: 6)
                            }
                        Button(action: {    // Button 8
                            self.userData.imageNumber = 7
                        }) {
                            self.imageForButton(buttonNumber: 7)
                            }
                        Button(action: {    // Button 9
                            self.userData.imageNumber = 8
                        }) {
                            self.imageForButton(buttonNumber: 8)
                            }
                       
                    }   // End of HStack
                    .imageScale(.medium)
                    .font(Font.title.weight(.regular))
                   
                    Spacer()
                    VStack {
                        // nav list to the APIS website
                        NavigationLink(destination:
                            WebView(url: "https://NewsAPI.org/")
                                .navigationBarTitle(Text("NewsAPI.org"), displayMode: .inline) )
                            {
                                Text("Powered By: NewsAPI.org")
                            }

                    }
                    Spacer()
                   
                }   // End of VStack
                .onAppear() {
                    self.userData.startTimer()
                }
                .onDisappear() {
                    self.userData.stopTimer()
                }
               
            }   // End of ZStack
           
        }   // End of NavigationView
       
    }
   
    func imageForButton(buttonNumber: Int) -> Image {
   
        if self.userData.imageNumber == buttonNumber {
            return Image(systemName: "\(buttonNumber+1).circle.fill")
        } else {
            return Image(systemName: "\(buttonNumber+1).circle")
        }
    }

}
