//
//  YouTubeVideoView.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI
import WebKit

struct YouTubeVideoView: UIViewRepresentable {
    let videoId: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = .init()
        return WKWebView(frame: .zero, configuration: config)
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)?playsinline=1") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: url))
    }
}
