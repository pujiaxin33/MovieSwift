//
//  Cast.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 09/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

struct People: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    var character: String?
    var department: String?
    let profile_path: String?
        
    let known_for_department: String?
    var known_for: [KnownFor]?
    let also_known_as: [String]?
    
    let birthDay: String?
    let deathDay: String?
    let place_of_birth: String?
    
    let biography: String?
    let popularity: Double?
    
    var images: [ImageData]?
    
    struct KnownFor: Codable, Identifiable, Hashable {
        let id: Int
        let original_title: String?
        let poster_path: String?
    }
}

extension People {
    var knownForText: String? {
        guard let knownFor = known_for else {
            return nil
        }
        let names = knownFor.filter{ $0.original_title != nil}.map{ $0.original_title! }
        return names.joined(separator: ", ")
    }
}

let samplePeople = People(
    id: 1,
    name: "John Doe",
    character: "Main Character",
    department: "Acting",
    profile_path: "/profile_path.jpg",
    known_for_department: "Acting",
    known_for: [
        People.KnownFor(
            id: 101,
            original_title: "Famous Movie",
            poster_path: "/poster_path.jpg"
        ),
        People.KnownFor(
            id: 102,
            original_title: "Another Hit",
            poster_path: "/another_poster.jpg"
        )
    ],
    also_known_as: ["Johnny", "JD"],
    birthDay: "1985-06-15",
    deathDay: nil,
    place_of_birth: "Los Angeles, California, USA",
    biography: "John Doe is an acclaimed actor known for his diverse roles in major films.",
    popularity: 75.5,
    images: [
        ImageData(
            aspect_ratio: 1.78,
            file_path: "/images/sample_image.jpg",
            height: 1080,
            width: 1920
        )
    ]
)

let samplePeopleCantShowBiography = People(
    id: 1,
    name: "John Doe",
    character: "Main Character",
    department: "Acting",
    profile_path: "/profile_path.jpg",
    known_for_department: "Acting",
    known_for: [
        People.KnownFor(
            id: 101,
            original_title: "Famous Movie",
            poster_path: "/poster_path.jpg"
        ),
        People.KnownFor(
            id: 102,
            original_title: "Another Hit",
            poster_path: "/another_poster.jpg"
        )
    ],
    also_known_as: ["Johnny", "JD"],
    birthDay: nil,
    deathDay: nil,
    place_of_birth: nil,
    biography: nil,
    popularity: 75.5,
    images: [
        ImageData(
            aspect_ratio: 1.78,
            file_path: "/images/sample_image.jpg",
            height: 1080,
            width: 1920
        )
    ]
)
