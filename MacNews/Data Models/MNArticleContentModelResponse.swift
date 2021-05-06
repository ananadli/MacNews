//
//  MNArticleContentModel.swift
//  MacNews
//
//  Created by Anan Suliman on 02/05/2021.
//

import Foundation

//The data model response for getArticleContent(article:) endpoint 

struct MNArticleContentModelResponse :Codable {
    
    let hypertTextContent: String
    let author : String
    let id = UUID()
    let idPath: String
    let title : String
    let pubDate : Date
    let category : String
    let thumbnail : String
    let context : String
    
    
    enum CodingKeys: String, CodingKey {
       case hypertTextContent = "content"
       case author
        case idPath = "@id"
        case title
        case pubDate
        case category
        case thumbnail
        case context = "@context"
     }
    
    init(from decoder: Decoder) throws {
        
    let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idPath = try container.decode(String.self, forKey: .idPath)
        self.title = try container.decode(String.self, forKey: .title)
       

        let pudStringDate = try container.decode(String.self, forKey: .pubDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        self.pubDate = dateFormatter.date(from: pudStringDate)!
        
        
        self.category = try container.decode(String.self, forKey: .category)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.context = try container.decode(String.self, forKey: .context)
        self.hypertTextContent = try container.decode(String.self, forKey: .hypertTextContent)
        self.author = try container.decode(String.self, forKey: .author)



    }
 
}
