//
//  CustomTF.swift
//  TsRv3
//
//  Created by Robin Fournier on 23/05/2021.
//

import SwiftUI

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var OutlineColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                    VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                }.cornerRadius(30)
            )
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
//                        .overlay(RoundedRectangle(cornerRadius: 30)
//                                    .stroke(OutlineColor, lineWidth: 2.5))
            .font(.custom("Poppins", size: 15))
            .shadow(radius: 10)
    }
}

struct CustomTF: View {
    @Binding var text : String
    @State var placeholder : String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField(placeholder, text: $text)
            }.modifier(customViewModifier(roundedCornes: 6, startColor: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), endColor: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)), OutlineColor: .white, textColor: .white))
        }.padding(.horizontal)
    }
}

struct CustomTF_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
//            CustomTF(text: "", placeholder: "Task Name")
        }
    }
}
