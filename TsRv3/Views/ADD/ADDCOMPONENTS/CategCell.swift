//
//  CategCell.swift
//  TsRv3
//
//  Created by Robin Fournier on 23/05/2021.
//

import SwiftUI

struct CategCell: View {
    @State var color: Color
    @State var illustration : String
    @State var theme : String
    
    var width = UIScreen.main.bounds.size.width / 4
    var height = UIScreen.main.bounds.size.height / 8.5

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(color)
                .frame(width : width, height: height)
                .shadow(color: Color(Color.RGBColorSpace.sRGB, white: 0.2, opacity: 0.4), radius: 4)
            
//            VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
//                .cornerRadius(30)
//                .frame(width : width, height: height)
            
            VStack {
                Image(illustration)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width : width, height: UIScreen.main.bounds.size.height / 15)
                
                Text(theme)
                    .font(.custom("Poppins", size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
        }
//        .padding(.vertical)

    }
}

struct CategCell_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            Background()
            HStack(spacing : 15) {
                CategCell(color: .blue, illustration: "Illustration4", theme: "SPORT")
                CategCell(color: .pink, illustration: "Illustration5", theme: "MEDIC")
                CategCell(color: .yellow, illustration: "Illustration2", theme: "SCHOOL")
                CategCell(color: .green, illustration: "Illustration4", theme: "FRIEND")
            }
        }
    }
}
