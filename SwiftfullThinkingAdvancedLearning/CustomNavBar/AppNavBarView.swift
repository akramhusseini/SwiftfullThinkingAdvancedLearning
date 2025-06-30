//
//  AppNavBarView.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 23/06/2025.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(destination: Text("destination")
                    .customNavBarItems(title: "Second Screen", subTitle: "Subtitle should be showing!!!!")
                ) {
                    Text("Navigate")
                }
            }
            .customNavBarItems(title: "New Title", subTitle: "Subtitle!", backButtonHidden: true)
        }
        
    }
}

#Preview {
    AppNavBarView()
}

extension AppNavBarView {
    
    private var defaultNavView: some View {
        NavigationView {
            CustomNavView {
                ZStack {
                    Color.green.ignoresSafeArea()
                    
                    NavigationLink(
                        destination: Text("Destination")
                            .navigationTitle("Title 2")
                            //.navigationBarBackButtonHidden(true),
                       ,
                        label: {
                            Text("Navigate")
                               
                        })
                }
            }
            
          
        }
    }
    
}
