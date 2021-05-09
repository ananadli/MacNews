//
//  MNArticleViewModel.swift
//  MacNews
//
//  Created by Anan Suliman on 06/05/2021.
//

import Foundation
import Combine

class MNArticleDetailsViewModel: ObservableObject {
    
    @Published var article : MNArticleModel
    var cancellables = Set<AnyCancellable>()
    
    
    init(article : MNArticleModel) {
        self.article = article
        self.fetchArticleDetails()
    }
    
    func fetchArticleDetails() {
        
        let cancellable = MNMacNewsAPI.fetchArticleContentService(article:article)
      
            
        
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }

            }) { (articalContentResponse) in
                DispatchQueue.main.async {
                    
                
                self.article = articalContentResponse
                }

            }
        cancellables.insert(cancellable)
    }
    
}
