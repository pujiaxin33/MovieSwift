//
//  FanClubViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import Foundation
import Networking
import Combine
import Observation

@Observable
class FanClubViewModel {
    private(set) var peoples: [People] = []
    private(set) var favoritePeople: [People] = []
    private(set) var currentPage: Int = 1
    var isLoading: Bool = false
    var isRefreshing: Bool = false
    var toast: Toast? = nil
    var isLoadFinished: Bool = false
    private let useCase: FanClubUseCase
    private var bags: Set<AnyCancellable> = .init()
    
    init(useCase: FanClubUseCase) {
        self.useCase = useCase
    }
    
    func loadData(_ handler: (() -> Void)? = nil) {
        isLoading = true
        let region = Locale.current.region?.identifier ?? "US"
        let params = ["page": "\(currentPage)",
                      "region": region]
        useCase.fetchPopularPersons(params: params)
            .sink { (completion) in
                self.isLoading = false
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.toast = .init(style: .error, message: error.localizedDescription)
                }
                handler?()
            } receiveValue: { (data: PaginatedResponse<People>) in
                if self.currentPage == 1 {
                    self.peoples = data.results
                } else {
                    self.peoples.append(contentsOf: data.results)
                }
                self.currentPage += 1
            }.store(in: &bags)
    }
    
    func startRefresh() {
        isRefreshing = true
        loadData {
            self.isRefreshing = false
        }
    }
    
    func refreshFavoritePeople() {
        favoritePeople = useCase.queryAllPeoples()
    }
    
    func removePeople(people: People) {
        useCase.remove(people)
    }
}
