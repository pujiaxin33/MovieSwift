//
//  ImagesCarouselView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/15.
//

import SwiftUI

struct ImagesCarouselView: View {
    let images: [ImageData]
    @Binding var selectedImage: ImageData?
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(images) { image in
                                GeometryReader { reader2 in
                                    MoviePosterView(path: image.file_path, urlSize: .original, size: .big)
                                        .id(image.id)
                                        .scaleEffect(scaleFactor(geometry: reader2))
                                }.frame(width: 250, height: 375)
                            }
                        }
                    }
                    .onAppear {
                        proxy.scrollTo(selectedImage?.id ?? "", anchor: .center)
                    }
                }
                
                Button(role: .destructive) {
                    selectedImage = nil
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                }
                .frame(width: 50, height: 50)
                .position(x: reader.frame(in: .local).midX, y: reader.frame(in: .local).maxY - 120)
            }
        }
    }
    
    // 计算缩放因子，根据图片相对屏幕中心的距离调整大小
    func scaleFactor(geometry: GeometryProxy) -> CGFloat {
        let midX = geometry.frame(in: .global).midX
//        print(midX)
        let screenWidth = UIScreen.main.bounds.width
        
        // 计算视图与屏幕中心的距离
        let distanceFromCenter = abs(screenWidth / 2 - midX)
        
        // 计算缩放比例，距离中心越远，缩放比例越小
        let maxScale: CGFloat = 1 // 增加最大缩放比例
        let minScale: CGFloat = 0.1
        let scale = max(minScale, maxScale - (distanceFromCenter / screenWidth) * 0.6 )
//        print(scale)
        return scale
    }
}

