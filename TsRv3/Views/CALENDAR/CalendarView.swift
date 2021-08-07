//
//  CalendarView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct CalendarView: View {
    @State private var isShowingAddTask = false
    
    var body: some View {
        VStack {
            CalendarHome()
            Button(action: {
                isShowingAddTask.toggle()
            }, label: {
                ZStack {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.142719686, green: 0.4182843864, blue: 0.9918132424, alpha: 1)))
                        .frame(width: 50, height: 50)
                    Image(systemName: "plus")
                        .font(Font.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                .padding(7)
                .contentShape(Rectangle())
                //                Text("Add Task")
            })
            .padding(.bottom, 18)
            .sheet(isPresented: $isShowingAddTask, content: {
                AddTaskView()
            })
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            CalendarView()
        }
    }
}
