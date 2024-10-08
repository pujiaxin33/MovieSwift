//
//  ShowLoadingModifier.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/8.
//

import Foundation
import SwiftUI
import Combine
import Observation

struct ShowLoadingModifier: ViewModifier {
    let isLoading: Binding<Bool>
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        return content
            .overlay {
                if isLoading.wrappedValue {
                    ProgressView {
                        Text("Loading")
                            .foregroundStyle(Color.blue)
                    }
                    .tint(.blue)
                    .frame(width: 100, height: 100)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
    }
}

extension View {
    func showLoading(_ isLoading: Binding<Bool>) -> some View {
//        return modifier(ShowLoadingModifier(isLoading: isLoading))
        return ModifiedContent(content: self, modifier: ShowLoadingModifier(isLoading: isLoading))
    }
}
