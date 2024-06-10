//
//  WebConnector.swift
//  Familiar
//
//  Created by 준호 on 6/4/24.
//

import SwiftUI
import WebKit
import UIKit

struct WebConnecter: UIViewRepresentable {
    var urlToLoad: String
        
    func makeUIView(context: Context) -> WKWebView { //웹뷰 반환
        guard let url = URL(string: self.urlToLoad) else{
            return WKWebView()
        }

        let webview = WKWebView()
        
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
   
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebConnecter>) {
    }
    
}

struct WebConnecter_Previews: PreviewProvider {
    static var previews: some View {
        WebConnecter(urlToLoad: "https://github.com/ryuwon2407")
    }
}
