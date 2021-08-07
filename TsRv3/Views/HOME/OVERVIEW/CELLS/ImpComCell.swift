//
//  ImpComCell.swift
//  TsRv3
//
//  Created by Robin Fournier on 22/05/2021.
//

import SwiftUI

struct ImpComCell: View {
    @State var color: Color
    @State var illustration : String
    @State var category : String
    
    var width = UIScreen.main.bounds.size.width / 2.5
    var height = UIScreen.main.bounds.size.height / 4
    
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
                    .frame(width : width, height: UIScreen.main.bounds.size.height / 6)

                
                Text(category)
                    .font(.custom("Poppins", size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
        }
    }
}

struct ImpComCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            HStack(spacing : 30) {
                ImpComCell(color: Color(#colorLiteral(red: 1, green: 0, blue: 1, alpha: 1)), illustration: "Illustration2", category: "IMPORTANT")
                ImpComCell(color: Color(#colorLiteral(red: 0, green: 0.4881326556, blue: 0.9849180579, alpha: 1)), illustration: "Illustration5", category: "COMPLEX")

            }
        }
    }
}
