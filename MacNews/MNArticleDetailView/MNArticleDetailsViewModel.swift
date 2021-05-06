//
//  MNArticleViewModel.swift
//  MacNews
//
//  Created by Anan Suliman on 06/05/2021.
//

import Foundation
import Combine

class MNArticleDetailsViewModel: ObservableObject {
    
    var article : MNArticleModel
    @Published var articleContentModelResponse : MNArticleContentModelResponse?
    @Published var isLoading : Bool = false
    var cancellables = Set<AnyCancellable>()
    
    
    init(article : MNArticleModel) {
        self.article = article
        
    }
    
    func fetchArticleDetails() {
      //  isLoading = true
        let cancellable = MNMacNewsAPI.getArticleContent(article:article)
      
            
        
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
              //  self.isLoading = false

            }) { (articalDetailsRespons) in
                self.articleContentModelResponse = articalDetailsRespons
        }
        cancellables.insert(cancellable)
    }
    
    
}
