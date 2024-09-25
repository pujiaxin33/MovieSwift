//
//  MoviesHomeViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import Foundation
import Networking
import Combine

@Observable
class MoviesHomeViewModel {
    var movies: [MoviesMenu : [Movie]] = [:]
    var genres: [Genre] = []
    
    private var bags: Set<AnyCancellable> = .init()
    
    init() {
        loadData()
    }
    
    func loadData() {
        
        let region = Locale.current.region?.identifier ?? "US"
        MoviesMenu.allCases.forEach { menu in
            if menu == .genres {
                APIService.shared.request(endpoint: menu.endpoint(params: ["page": "1", "region": region])).sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: {[weak self] (data: GenresResponse) in
                    self?.genres = data.genres
                }.store(in: &bags)
            } else {
                APIService.shared.request(endpoint: menu.endpoint(params: ["page": "1", "region": region])).sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: {[weak self] (data: PaginatedResponse<Movie>) in
                    self?.movies[menu] = data.results
                }.store(in: &bags)
            }
        }
    }
    
}
