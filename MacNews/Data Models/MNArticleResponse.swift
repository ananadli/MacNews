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

struct MNArticleModel : Codable,Identifiable,Hashable,Equatable {
    static func == (lhs: MNArticleModel, rhs: MNArticleModel) -> Bool {
        lhs.idPath == rhs.idPath
    }
    
    
    let id = UUID()
    let idPath: String
    let title : String
    let pubDate : Date
    let category : String
    let thumbnail : String
    var hypertTextContent: String
    var author : String
    var context : String
   
    init(idPath : String) {
        self.idPath = idPath
        self.title = ""
        self.pubDate = Date()
        self.category = ""
        self.thumbnail = ""
        self.hypertTextContent = ""
        self.author  = ""
        self.context = ""
    }
    init(idPath : String,title : String , pubDate : Date , category:String,thumbnail:String,hypertTextContent:String,author : String) {
        self.idPath = idPath
        self.title = title
        self.pubDate = pubDate
        self.category = category
        self.thumbnail = thumbnail
        self.hypertTextContent = ""
        self.author  = ""
        self.context = ""
    }
    enum CodingKeys: String, CodingKey {
        case idPath = "@id"
        case title
        case pubDate
        case category
        case thumbnail
        case author
        case hypertTextContent = "content"
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
        
        
        do {
            self.author = try container.decode(String.self, forKey: .author)
            self.hypertTextContent = try container.decode(String.self, forKey: .hypertTextContent)
            self.context = try container.decode(String.self, forKey: .context)


        } catch _ {
            self.author = ""
            self.hypertTextContent = ""
            self.context = ""
        }

        

    }
    
    
    func getRelativePubDateFormat() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self.pubDate, relativeTo: Date())
    }

    
}



