//
//  MacNewsApp.swift
//  MacNews
//
//  Created by Anan Suliman on 01/05/2021.
//

import SwiftUI


@main
struct MacNewsApp: App {
    @AppStorage(UserDefaultsKeys.FirstOpen.rawValue) var isFirstOpen : Bool = true
    @ObservedObject var deepLinkManeger  = MNDeepLinkManeger()

    var body: some Scene {
        WindowGroup {
            MNArticlesSwiftUIView().environmentObject(deepLinkManeger).sheet(isPresented: $isFirstOpen, content: {
                MNOnboardingViewSwiftUIView(isFirstOpen: $isFirstOpen)
            }).onOpenURL(perform: { url in
                //Passing the URL to the deeplink manager
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

