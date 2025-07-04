//
//  CastView.swift
//  MovieDB
//
//  Created by Shubham on 04/07/25.
//

import SwiftUI

struct CastView: View {
    
    // MARK: - Variables
    var castMember: CastMember
    
    var width: CGFloat = 200
    var height: CGFloat = 200

    // MARK: - Views
    var body: some View {
        
        HStack {
            URLImageView(imageURLString: castMember.profilePath, width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(castMember.name)
                .font(.system(size: 19, weight: .bold))
            
            Spacer()
        }
    }
}

#Preview {
    CastView(castMember: CastMember(id: 9, name: "Robert Di Niro", character: "", profilePath: ""))
}
