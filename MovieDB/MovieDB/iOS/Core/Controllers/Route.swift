//
//  NavigationItem.swift
//  MovieDB
//
//  Created by Shubham on 02/07/25.
//

import SwiftUI

enum Route: Hashable {
    case favorites
    case seeAll(category: MovieCategory)
}
