//
//  MNArticleModel.swift
//  MacNews
//
//  Created by Anan Suliman on 02/05/2021.
//

import Foundation
import Combine


//The network request response for getAllArticles endpoint
struct MNArticleResponse : Codable {
    
    var articles : [MNArticleModel]
    
    
    enum CodingKeys: String, CodingKey {
       case articles = "hydra:member"
     }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.articles = try container.decode([MNArticleModel].self, forKey: .articles)
        
    }
}

struct MNArticleModel : Codable,Identifiable,Hashable {
    
    let id = UUID()
    let idPath: String
    let title : String
    let pubDate : Date
    let category : String
    let thumbnail : String
    
    
    enum CodingKeys: String, CodingKey {
        case idPath = "@id"
        case title
        case pubDate
        case category
        case thumbnail
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
    }
    
    
    func getRelativePubDateFormat() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self.pubDate, relativeTo: Date())
    }
    
}



