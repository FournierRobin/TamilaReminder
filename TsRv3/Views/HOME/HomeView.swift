//
//  HomeView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(
        entity: Profile.entity(),
        sortDescriptors: []
    ) var profile: FetchedResults<Profile>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            HelloName(profile: profile[0])
                .padding(.top, 30)
            OPTabMenu()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            HomeView()
        }
    }
}
