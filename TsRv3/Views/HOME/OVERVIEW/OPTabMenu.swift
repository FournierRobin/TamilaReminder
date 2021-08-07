//
//  OPTabMenu.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct OPTabMenu: View {
    
    @State var selectedMenu = 0
//    @State var SBClicked = false
    @Namespace var animation
//    @State var modalState = CGSize.zero
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HStack(alignment : .center) {
                    ZStack {
                        if selectedMenu == 0 {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color(#colorLiteral(red: 0.142719686, green: 0.4182843864, blue: 0.9918132424, alpha: 1)))
                                .frame(width: 105, height: 33)
                                .matchedGeometryEffect(id: "selectedMenu", in: animation)
                        }
                        
                        Text("Overview")
                            .foregroundColor(selectedMenu == 0 ? Color.white : Color.gray)
                            .font(.custom("Poppins", size: 15))
                            .fontWeight(.semibold)
                            .padding(15)
                            .padding(.horizontal, 5)
                            .contentShape(Rectangle())
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0)) {
                            selectedMenu = 0
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        if selectedMenu == 1 {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color(#colorLiteral(red: 0.142719686, green: 0.4182843864, blue: 0.9918132424, alpha: 1)))
                                .frame(width: 125, height: 33)
                                .matchedGeometryEffect(id: "selectedMenu", in: animation)
                        }
                        
                        Text("Productivity")
                            .foregroundColor(selectedMenu == 1 ? Color.white : Color.gray)
                            .font(.custom("Poppins", size: 15))
                            .fontWeight(.semibold)
                            .padding()
                            .contentShape(Rectangle())
                    }.onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0)) {
                            selectedMenu = 1
                        }
                    }.fixedSize()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                
                switch selectedMenu {
                case 0 : ListTaskView2()
                case 1 : ProductivityView()
                default : ListTaskView2()
                }
                Spacer()
            }
        }
    }
}

struct OPTabMenu_Previews: PreviewProvider {
    static var previews: some View {
        OPTabMenu()
    }
}
