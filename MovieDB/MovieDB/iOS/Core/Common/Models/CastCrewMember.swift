//
//  CastCrewMember.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

struct CastMember: Decodable {
    let id: Int
    let name: String
    let character: String?
    let profilePath: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
