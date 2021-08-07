//
//  HelloName.swift
//  TsRv3
//
//  Created by Robin Fournier on 23/05/2021.
//

import SwiftUI

struct HelloName: View {
    var profile: Profile
    
    var body: some View {
        HStack(alignment : .top) {
            VStack(alignment: .leading) {
                Text("Hello,")
                    .font(.custom("Poppins", size: 40))
                    .fontWeight(.semibold)
                
                Text(profile.username! + " 👋")
                    .font(.custom("Poppins", size: 40))
                    .fontWeight(.semibold)
            }.foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            Spacer()
        }.padding(.leading, 30)
    }
}

struct HelloName_Previews: PreviewProvider {
    static var previews: some View {
        HelloName(profile: Profile())
    }
}
