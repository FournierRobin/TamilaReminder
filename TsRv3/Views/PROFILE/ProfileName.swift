//
//  ProfileName.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct ProfileName: View {
    var profile: Profile

    var body: some View {
        HStack {
            Text(profile.username!)
        }
    }
}

struct ProfileName_Previews: PreviewProvider {
    static var previews: some View {
        ProfileName(profile: Profile())
    }
}
