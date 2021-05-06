//
//  MNArticlesSwiftUIView.swift
//  MacNews
//
//  Created by Anan Suliman on 02/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct MNArticlesSwiftUIView: View {
    @ObservedObject var viewModel = MNArticleViewModel()

    var body: some View {
      
            NavigationView {
               
            ZStack {
                Color("background-color").ignoresSafeArea()

                LazyVStack(alignment: .leading, spacing: 0, content: {
                        ScrollView(.vertical, showsIndicators: true, content: {
                            
                    
                        ForEach(viewModel.articles, id: \.self) { item in
                        
                            MNArticleListItemView(article: item)
                        }
                    })
                    }).navigationBarTitle("Articles").ignoresSafeArea(.all, edges: .all).onAppear(perform: {
                        
                        
                        viewModel.getAllArticles()
                })
            }.navigationBarItems(trailing:
            
            
            
                Button(action: {
                    
                    viewModel.getAllArticles()
                }, label: {
                    if viewModel.isLoading{
                        ProgressView()
                    }else{
                    Image(systemName: "arrow.clockwise")
                    }
                })
            )
                
            }
        
        
}
  
}

struct MNArticlesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MNArticlesSwiftUIView()
    }
}

struct MNArticleListItemView: View {
    
    var article : MNArticleModel
    
    var body: some View {
        NavigationLink(
            destination: MNArticleDetailsSwiftUIView(viewModel: MNArticleDetailsViewModel(article: article)),
            label: {
                
           
        HStack(alignment: .center, spacing: 0, content: {
            
            WebImage(url: URL(string: article.thumbnail)).resizable().scaledToFill().frame(width: 90, height: 120, alignment: .center).background(Color(.lightGray)).cornerRadius(10).clipped().padding(.trailing, 10)
            
            
            VStack(alignment: .leading, spacing: 0, content: {
                VStack(alignment: .leading, spacing: 3, content: {
                    Text(article.category).font(.callout).foregroundColor(Color("category-color-text")).multilineTextAlignment(.leading)
                    Text(article.title).font(.headline).foregroundColor(.black).multilineTextAlignment(.leading)
                    Spacer()

                    MNArticleRelativeDateView(article: article)
                })
                
                
            })
           Spacer()
        }).padding()
            })
    }
}

struct MNArticleRelativeDateView: View {
    var article : MNArticleModel
    var body: some View {
        HStack(alignment: .center, spacing: 5, content: {
            Image(systemName: "clock.fill").foregroundColor(Color("subtitle-color")).font(.subheadline)
            
            Text( article.getRelativePubDateFormat()).foregroundColor(Color("subtitle-color")).font(.subheadline)
        })
    }
}
