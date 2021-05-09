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
    @ObservedObject var deepLinkManeger  = MNDeepLinkManeger()

    var body: some Scene {
        WindowGroup {
            MNArticlesSwiftUIView().environmentObject(deepLinkManeger).sheet(isPresented: $isFirstOpen, content: {
                MNOnboardingViewSwiftUIView(isFirstOpen: $isFirstOpen)
            }).onOpenURL(perform: { url in
                print(url.path)
                deepLinkManeger.openArticleRequest = MNOpenArticleRequest(url: url, articlePathId: url.path)
                deepLinkManeger.shouldOpen = true
                
            })
            
        }
    }
    
    
}

class Deeplinker {
    enum Deeplink: Equatable {
        case home
        case details(reference: String)
    }
    
}

