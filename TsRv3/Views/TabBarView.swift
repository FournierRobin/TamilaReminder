//
//  TabBarView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack {
            Background()
            switch selectedTab {
            case 0 : HomeView().zIndex(1)
            case 1 : CalendarView().zIndex(1)
            default : HomeView()
            }
            
            VStack {
                Spacer()
                
                ZStack(alignment:.bottom) {
                    
                    HStack() {
                        Button(action: {
                            selectedTab = 0
                        }, label: {
                            Image("HomeIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40, alignment: .center)
                                .offset(y : (selectedTab == 0) ? 0 : 4)
                                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                                .padding(7)
                                .contentShape(Rectangle())
                        }).padding(.leading, 25)
                        
                        Spacer()
                        
                        Button(action: {
                            selectedTab = 1
                        }, label: {
                            ZStack {
                                Text("M")
                                    .font(.custom("Poppins", size: 15))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9481830001, green: 1, blue: 0.9818691611, alpha: 1)))
                                    .padding(.top, 4)

                                Image("CalendarIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40, alignment: .center)
                                    
                                    .padding(7)
                                    .contentShape(Rectangle())
                            }.offset(y : (selectedTab == 1) ? 0 : 4)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                        }).padding(.trailing, 25)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
