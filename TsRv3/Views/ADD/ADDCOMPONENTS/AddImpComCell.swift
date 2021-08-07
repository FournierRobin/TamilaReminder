//
//  AddImpComCell.swift
//  TsRv3
//
//  Created by Robin Fournier on 23/05/2021.
//

import SwiftUI

struct AddImpComCell: View {
    @State var color: Color
    @State var illustration : String
    @State var category : String
    
    var width = UIScreen.main.bounds.size.width / 2.5
    var height = UIScreen.main.bounds.size.height / 5
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
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
                    .frame(width : width, height: UIScreen.main.bounds.size.height / 8)

                
                Text(category)
                    .font(.custom("Poppins", size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
        }
    }
}

struct AddImpComCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            HStack(spacing : 30) {
                AddImpComCell(color: Color(#colorLiteral(red: 1, green: 0, blue: 1, alpha: 1)), illustration: "Illustration2", category: "IMPORTANT")
                AddImpComCell(color: Color(#colorLiteral(red: 0, green: 0.4881326556, blue: 0.9849180579, alpha: 1)), illustration: "Illustration5", category: "COMPLEX")

            }
        }
    }
}
