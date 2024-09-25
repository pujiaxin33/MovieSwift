//
//  Movie+Ex.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import Foundation

extension Movie {
    var yearDurationStatusDisplayTitle: String {
        let strings = [publishYear, movieDuration, status]
        return strings.compactMap { $0 }.joined(separator: " • ")
    }
    
    var publishYear: String? {
        if let release_date, let date = Movie.dateFormatter.date(from: release_date) {
            return "\(Calendar.current.component(.year, from: date))"
        } else {
            return nil
        }
    }
    
    var movieDuration: String? {
        if let time = runtime {
            return "\(time) minutes"
        } else {
            return nil
        }
    }
    
    var voteAverageText: String {
        return "\(Int(vote_average))%"
    }
    
    var voteCountText: String {
        return "\(vote_count) ratings"
    }
}
