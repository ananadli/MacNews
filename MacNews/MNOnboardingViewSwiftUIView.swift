//
//  MNIntroViewSwiftUIView.swift
//  MacNews
//
//  Created by Anan Suliman on 01/05/2021.
//

import SwiftUI

struct MNOnboardingViewSwiftUIView: View {
    
    @Binding var isFirstOpen : Bool
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Spacer()
            Image("news-app-icon").resizable().frame(width: 200, height: 200, alignment: .center).scaledToFit()
            Spacer()
            Text("Welcome").font(.system(size: 20, weight: .bold, design: .default)).foregroundColor(Color("title-text-color")).padding()
            Text("Thanks for installing our app and hopefully you will enjoy using it.").multilineTextAlignment(.center).font(.callout).foregroundColor(Color("subtitle-text-color"))
            
            Spacer()
            
            HStack(alignment: .center, spacing: nil, content: {
                Spacer()
                Button(action: {
                    isFirstOpen.toggle()
                }, label: {
                    
                    Image(systemName: "arrow.right").foregroundColor(Color("button-text-color"))
                    
                }).frame(width: 50, alignment: .center).padding().background(Color("button-background-color")).cornerRadius(9)
                
                
            })
            
        }).padding().background(Color("background-color").ignoresSafeArea())
        
    }
}

struct MNIntroViewSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MNOnboardingViewSwiftUIView(isFirstOpen: .constant(false))
    }
}
