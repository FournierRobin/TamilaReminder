//
//  Background.swift
//  TsRv1
//
//  Created by Robin Fournier on 22/05/2021.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.2342249155, green: 0.04229363799, blue: 0.6375512481, alpha: 1))]), startPoint: .top, endPoint: .bottom)
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(1)]), startPoint: .top, endPoint: .bottom)
            VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
        }.ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
