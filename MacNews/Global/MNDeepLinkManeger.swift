//
//  MNDeepLinkManeger.swift
//  MacNews
//
//  Created by Anan Suliman on 09/05/2021.
//

import Foundation


class MNDeepLinkManeger: ObservableObject {
    
   @Published var openArticleRequest : MNOpenArticleRequest?
   @Published var shouldOpen : Bool = false //Value must be set false only by the navigation

    
}

struct MNOpenArticleRequest {
    var url : URL
    var articlePathId : String
}
