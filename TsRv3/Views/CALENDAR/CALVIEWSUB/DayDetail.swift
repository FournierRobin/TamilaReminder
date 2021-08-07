//
//  DayDetail.swift
//  CalendarTest
//
//  Created by Robin Fournier on 22/05/2021.
//

import SwiftUI

struct DayDetail: View {
    @Binding var selectedDay: Week
    @Binding var isZoomed: Bool
    
    var animation: Namespace.ID
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "date", ascending: true)
        ]
    ) var tasks: FetchedResults<Task>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func getDayOfTask(date: Date) -> String {
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "EEE"
        
        return formatter3.string(from: date)
    }
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius : 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .matchedGeometryEffect(id: "BG\(selectedDay.id)", in: animation)
            
            VStack(spacing: 12){
                HStack(alignment: .bottom, spacing: 12) {
                    Text(selectedDay.day)
                        .font(.custom("Poppins", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "jour\(selectedDay.id)", in: animation)
                    
                    Text(selectedDay.date)
                        .font(.custom("Poppins", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "date\(selectedDay.id)", in: animation)
                    
                }.padding(.top, 20)
                
                ForEach(tasks) { task in
                    if getDayOfTask(date: task.date!) == selectedDay.day {
                        if(task.isDone == false) {
                            HStack {
                                Text(task.title == "" ? "Pas de nom" : task.title!)
                                    .font(.custom("Poppins", size: 20))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 50)
                                
                                Spacer()
                                
                                VStack {
                                    switch task.category {
                                    case 0 : ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                                        Text("Sport")
                                            .font(.custom("Poppins", size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)

                                    }.fixedSize()
                                    
                                    case 1 : ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color(#colorLiteral(red: 0.4637110704, green: 0.6992980542, blue: 0.2889392376, alpha: 1)))
                                        Text("Medic")
                                            .font(.custom("Poppins", size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)
                                    }.fixedSize()
                                    
                                    case 2 : ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color(#colorLiteral(red: 1, green: 0.468347251, blue: 0.7559673283, alpha: 1)))
                                        Text("School")
                                            .font(.custom("Poppins", size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)

                                    }.fixedSize()
                                    
                                    case 3 : ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color(#colorLiteral(red: 0.1193125199, green: 0.116432657, blue: 0.7812529064, alpha: 1)))
                                        Text("Friend")
                                            .font(.custom("Poppins", size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)

                                    }.fixedSize()
                                    
                                    default : ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color.white.opacity(0.4))
                                        Text("No category")
                                            .font(.custom("Poppins", size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(5)

                                    }.fixedSize()
                                    }
                                }.padding(.trailing, 50)
                            }
                        }
                    }
                }
            }
            
        }.frame(height: UIScreen.main.bounds.size.height / 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0)) {
                isZoomed = false
            }
        }
    }
}


