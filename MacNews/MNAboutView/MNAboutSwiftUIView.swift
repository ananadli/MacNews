//
//  MNAboutSwiftUIView.swift
//  MacNews
//
//  Created by Anan Suliman on 09/05/2021.
//

import SwiftUI
struct MNAboutSwiftUIView: View {
    
    @Binding var showAboutView : Bool

    var body: some View {
        ZStack {

            VStack(alignment: .center, spacing: nil, content: {
                //find the about.md file in the main bundle
                if let fileURL = Bundle.main.url(forResource: "about", withExtension: "md") {
                    //Fetch the content of the file
                    if let fileContents = try? String(contentsOf: fileURL) {
           //passing the file content to the MNMarkdoenView to display in DownView
MNMarkdownView(markdown: fileContents)
                        
                    }            }
                Spacer()
            }).padding()
        }
        
    }
}

struct MNAboutSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MNAboutSwiftUIView(showAboutView: .constant(false))
    }
}
