//
//  MockFanClubPeopleStorage.swift
//  SwiftMovieAppTests
//
//  Created by Jiaxin Pu on 2024/10/8.
//

import Foundation
@testable import SwiftMovieApp


class MockFanClubPeopleStorage: FanClubPeopleStorage {
    let peoples: [People]
    
    init(peoples: [People]) {
        self.peoples = peoples
    }
    
    func createTable() {}
    func save(_ people: People) {}
    func remove(_ people: People) {}
    func queryAllPeoples() -> [People] { return peoples}
    func deleteAllPeoples() {}
}
