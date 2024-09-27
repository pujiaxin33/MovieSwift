//
//  FanClubViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import Foundation
import Networking
import Combine

@Observable
class FanClubViewModel {
    let repository: FanClubRepository
    var peoples: [People]?
    private var currentPage: Int = 1
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: FanClubRepository) {
        self.repository = repository
    }
    
    func loadData() {
        let region = Locale.current.region?.identifier ?? "US"
        let params = ["page": "\(currentPage)",
                      "region": region]
        repository.fetchPopularPersons(params: params)
            .sink { _ in
                
            } receiveValue: { (data: PaginatedResponse<People>) in
                self.peoples = data.results
            }.store(in: &bags)
    }
}