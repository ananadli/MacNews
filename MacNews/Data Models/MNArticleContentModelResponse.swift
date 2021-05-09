//
//  MNArticleContentModel.swift
//  MacNews
//
//  Created by Anan Suliman on 02/05/2021.
//

import Foundation

//The data model response for getArticleContent(article:) endpoint 

struct MNArticleContentModel :Codable,Hashable {
    
    let hypertTextContent: String
    let author : String
   
    let context : String
    
    enum CodingKeys: String, CodingKey {
       case hypertTextContent = "content"
       case author
       case context = "@context"
     }
    init(hypertTextContent: String, author : String, context : String) {
        self.hypertTextContent = hypertTextContent
        self.author  = author
        self.context = context
    }
    init(from decoder: Decoder) throws {
        
    let container = try decoder.container(keyedBy: CodingKeys.self)

        
        self.context = try container.decode(String.self, forKey: .context)
        self.hypertTextContent = try container.decode(String.self, forKey: .hypertTextContent)
        self.author = try container.decode(String.self, forKey: .author)


    }
    
 
 
}
