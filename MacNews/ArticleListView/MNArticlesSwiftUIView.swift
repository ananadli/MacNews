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
    @AppStorage(UserDefaultsKeys.BookmarkedArticles.rawValue) var bookmarkList : [String] = []
    @State var showBookmarked : Bool = false
    @EnvironmentObject var deepLinkManeger : MNDeepLinkManeger
    var body: some View {
      
            NavigationView {
               
            ZStack {
                
                if deepLinkManeger.openArticleRequest != nil {
                NavigationLink(
                    destination: MNArticleDetailsSwiftUIView(viewModel: MNArticleDetailsViewModel(article: MNArticleModel(idPath: (deepLinkManeger.openArticleRequest?.articlePathId)!))),
                    isActive: $deepLinkManeger.shouldOpen,
                    label: {
                        
                    })
                }
                
                Color("background-color").ignoresSafeArea()
               
                 
                VStack(alignment: .center, spacing: 0, content: {
                    
                
                    MNArticleListNavigationView(showBookmarked: $showBookmarked, viewModel: viewModel)
                    LazyVStack(alignment: .leading, spacing: 0, content: {
                                ScrollView(.vertical, showsIndicators: true, content: {
                                    
                            
                                    ForEach(viewModel.articles, id: \.id) { item in
                                        if showBookmarked == true   {
                                            if bookmarkList.contains(item.idPath) {
                                                
                                    MNArticleListItemView(article: item)
                                            }
                                        }else{
                                            MNArticleListItemView(article: item)
                                        }
                                }

                            })

                    }).navigationBarTitle("Articles").onAppear(perform: {
                                

                       
                        
                        })
                    Spacer()

                })
                
            }.navigationBarHidden(true)
                
            }
        
        
}
  
}

struct MNArticlesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MNArticlesSwiftUIView( ).environmentObject(MNDeepLinkManeger())
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

struct MNArticleListNavigationView: View {
    @Binding var showBookmarked : Bool
    @ObservedObject var viewModel : MNArticleViewModel

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            HStack {
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.fetchAllArticles()
                }, label: {
                    ZStack{
                    if viewModel.isLoading{
                        ProgressView().foregroundColor(.black)
                    }else{
                        Image(systemName: "arrow.clockwise") .foregroundColor(.black).font(.system(size: 20, weight: .medium, design: .default))
                        
                    }
                    }
                })
                
                
            }
            HStack {
                Text("Articles").font(.system(size: 30, weight: .bold, design: .default)).foregroundColor(.black).multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    
                    showBookmarked.toggle()
                }, label: {
                    
                    Image(systemName: showBookmarked ? "bookmark.circle.fill" : "bookmark.circle")
                        .foregroundColor(.black).font(.system(size: 25, weight: .medium, design: .default))
                    
                })

            }
            
        }).padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
    }
}
