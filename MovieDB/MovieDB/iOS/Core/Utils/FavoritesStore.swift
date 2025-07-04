//
//  FavoritesStore.swift
//  MovieDB
//
//  Created by Shubham on 04/07/25.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var favoriteMovieIDs: [Int64] = []
    
    
    // MARK: - Functions
    func removeMovieId(_ movieID: Int64) {
        self.favoriteMovieIDs = self.favoriteMovieIDs.filter { $0 != Int64(movieID) }
    }
}
