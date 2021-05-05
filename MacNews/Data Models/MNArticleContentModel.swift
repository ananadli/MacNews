//
//  MNArticleContentModel.swift
//  MacNews
//
//  Created by Anan Suliman on 02/05/2021.
//

import Foundation

//The data model response for getArticleContent(article:) endpoint 

struct MNArticleContentModelResponse :Codable {
    
    var hypertTextContent: String
    var author : String
   
    
    enum CodingKeys: String, CodingKey {
       case hypertTextContent = "content"
       case author
     }
 
}
