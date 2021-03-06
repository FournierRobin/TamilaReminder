//
//  ContentView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(
        entity: Profile.entity(),
        sortDescriptors: []
    ) var profile: FetchedResults<Profile>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        if(profile.isEmpty){
            WelcomeView()
        } else {
            TabBarView()
        }    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
