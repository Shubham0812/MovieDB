//
//  MovieCreditResponse.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

struct MovieCreditsResponse: Decodable {
    let id: Int
    let cast: [CastMember]
}
