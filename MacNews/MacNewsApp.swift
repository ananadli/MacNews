//
//  MacNewsApp.swift
//  MacNews
//
//  Created by Anan Suliman on 01/05/2021.
//

import SwiftUI


@main
struct MacNewsApp: App {
    @AppStorage("isFirstOpen") var isFirstOpen : Bool = true
    var body: some Scene {
        WindowGroup {
            MNArticlesSwiftUIView( ).sheet(isPresented: $isFirstOpen, content: {
                MNOnboardingViewSwiftUIView(isFirstOpen: $isFirstOpen)
            })
            
        }
    }
}



