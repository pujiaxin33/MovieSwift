//
//  Genre.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 15/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

struct Genre: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}
