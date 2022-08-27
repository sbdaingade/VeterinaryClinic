//
//  PetDetailView.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import SwiftUI
import WebKit

struct PetDetailView: UIViewRepresentable {
    let pet: Pet
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: pet.contentURL)!)
        webView.load(request)
    }
    
}
