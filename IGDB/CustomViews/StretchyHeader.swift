//
//  StretchyHeader.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//

import SwiftUI
import Domain

struct GeometryProxyReader {
    
    static var safeAreaTopOffset: CGFloat?
    
    static func getScrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).minY
    }
    
    static func getOffsetForHeader(_ proxy: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(proxy)
        if offset > 0 {
            return -offset
        }
        return 0
    }
    
    static func getHeightForHeader(_ proxy: GeometryProxy) -> CGFloat {
        let offSet = getScrollOffset(proxy)
        let imageHeight = proxy.size.height
        if offSet > 0 {
            return imageHeight + offSet
        }
        return imageHeight
    }
}

struct StretchyHeader: View {
    var imageURL: URL
    
    var body: some View {
        GeometryReader { proxy in
            
            CachedAsyncImage(
                url: imageURL,
                content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            image
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 30, opaque: true)
                                .mask(
                                    LinearGradient(
                                        gradient: Gradient(
                                            stops: [
                                                Gradient.Stop(color: Color(white: 0, opacity: 0), location: 0.65),
                                                Gradient.Stop(color: Color(white: 0, opacity: 1), location: 0.8)
                                            ]
                                        ),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .overlay(
                                    LinearGradient(
                                        gradient: Gradient(
                                            stops: [
                                                Gradient.Stop(color: Color(white: 0, opacity: 0), location: 0.6),
                                                Gradient.Stop(color: Color(white: 0, opacity: 0.25), location: 1)
                                            ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        }
                        .frame(
                            width: proxy.size.width,
                            height: GeometryProxyReader.getHeightForHeader(proxy)
                        )
                        .clipped()
                        .offset(y: GeometryProxyReader.getOffsetForHeader(proxy))
                }, placeholder: {
                    Image("emptyImage")
                        .resizable()
                }
            )
        }
        .frame(height: UIScreen.main.bounds.width / 0.75)
    }
}
