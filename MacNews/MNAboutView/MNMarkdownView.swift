//
//  MNMarkdownView.swift
//  MacNews
//
//  Created by Anan Suliman on 09/05/2021.
//

import Foundation
import SwiftUI
import Down
struct MNMarkdownView : UIViewRepresentable {
    var markdown : String
    func makeUIView(context: Context) -> DownView  {
      
        let downView = try! DownView(frame: CGRect.zero, markdownString: markdown) {
            // Optional callback for loading finished
        }
        return downView
    }
    func updateUIView(_ webView: DownView, context: Context) {
    }
}
