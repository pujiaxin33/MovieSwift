//
//  DiscoverView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/10.
//

import SwiftUI

struct DiscoverView: View {
    let coordinator: UIModuleCoordinator
    @State var viewModel: DiscoverViewModel
    @State private var navigation = Navigation()
    @State private var listId: UUID = UUID()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            ZStack {
                // 使用 ScrollView 和 HStack 创建横向滚动视图
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(viewModel.movies) { movie in
                            // 使用 GeometryReader 获取每个图片的相对位置
                            GeometryReader { geometry in
                                // 图片视图
                                NavigationLink(value: movie) {
                                    MoviePosterView(path: movie.poster_path, size: .big)
                                    // 动态缩放，根据每个视图相对于屏幕中心的距离调整缩放效果
                                        .scaleEffect(scaleFactor(geometry: geometry))
                                }
                            }
                            .frame(width: 250, height: 375)
                            
                        }
                    }
                }
                .id(listId)
                
                GeometryReader { reader in
                    Button {
                        listId = UUID()
                        viewModel.loadData()
                    } label: {
                        Text("Random")
                    }
                    .position(x: reader.frame(in: .local).midX, y: reader.frame(in: .local).maxY - reader.safeAreaInsets.bottom - 30)
                }
            }
            .navigationTitle("Discover")
            .registerUIModuleNavigationDestinations(with: coordinator)
            .onFirstAppear {
                viewModel.loadData()
            }
        }.environment(\.navigation, navigation)
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
