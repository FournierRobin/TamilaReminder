//
//  GoBackChevron.swift
//  TsRv1
//
//  Created by Robin Fournier on 29/04/2021.
//

import SwiftUI

struct GoBackChevron: View {
    var body: some View {
        Image(systemName: "chevron.left")
            .foregroundColor(.white)
            .font(Font.system(size: 25, weight: .semibold))
            .padding(15)
            .contentShape(Rectangle())
        
    }
}

struct GoBackChevron_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            GoBackChevron()
        }
    }
}
