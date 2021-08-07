//
//  WelcomeView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 23/05/2021.
//

import SwiftUI

struct WelcomeView: View {
    @State var profileConfig = NewProfileConfig()
    
    @FetchRequest(
        entity: Profile.entity(),
        sortDescriptors: []
    ) var profile: FetchedResults<Profile>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack {
            Background()
            
            VStack(spacing : 20) {
                Text("Welcome !")
                    .font(.custom("Poppins", size: 30))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                
                Text("Let's get to know each other")
                    .font(.custom("Poppins", size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                
                VStack(spacing: 20) {
                    Text("Enter your name : ")
                        .font(.custom("Poppins", size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    
                    CustomTF(text: $profileConfig.username, placeholder: "Profile Name")
                }.padding(.top, 50)

                Spacer()
                
                Button(action: {
                    let newProfile = Profile(context: viewContext)
                    newProfile.username = profileConfig.username
                    hideKeyboard()
                    do {
                        try viewContext.save()
                    } catch {
                        print("Erreur lors de l'enregistrement")
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                        Text("Save Profile")
                            .font(.custom("Poppins", size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 100)
                    }
                    .fixedSize()
                })
            }.padding(.top, 100)
            .padding(.bottom, 50)
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

extension WelcomeView {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
