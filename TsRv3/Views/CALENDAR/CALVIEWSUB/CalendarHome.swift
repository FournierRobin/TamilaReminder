//
//  CalendarHome.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 22/05/2021.
//

import SwiftUI

struct CalendarHome: View {
 
    // For Segment Tab Slide....
    @Namespace var animation
    
    @State var weeks : [Week] = []
    
    // Current Week Day...
    @State var currentDay: Week = Week(day: "", date: "")
    
    var body: some View {
        
        VStack{
            BottomSheet(weeks: $weeks, currentDay: $currentDay)
                .padding([.horizontal,.top])
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            getWeekDays()
        })
    }
    
    // getting Current Week 7 Days...
    func getWeekDays(){
        
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let startDate = week?.start else{
            return
        }
        
        // whole week days...
        
        for index in 0..<7{
            
            guard let date = calender.date(byAdding: .day, value: index, to: startDate) else{
                return
            }
            
            let formatter = DateFormatter()
            // EEE will be used to get day like Mon,Tue...
            formatter.dateFormat = "EEE"
            let day = formatter.string(from: date)
            // Since we need like Mo Tu....
//            day.removeLast()
            
            formatter.dateFormat = "dd"
            let dateString = formatter.string(from: date)
            
            // Random Amount...
            weeks.append(Week(day: day, date: dateString))
        }
        
        self.currentDay = weeks.first!
    }
}

struct CalendarHome_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            CalendarHome()
        }
    }
}

struct BottomSheet: View {
    
    @Binding var weeks: [Week]
    @Binding var currentDay: Week
    @Namespace var animation
    @State var isZoomed = false

    var count = 0
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "date", ascending: true)
        ]
    ) var tasks: FetchedResults<Task>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func getDayOfTask(date: Date) -> String {
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd"
        return formatter3.string(from: date)
    }
    
    func getTaskCount(date : String) -> Int {
        var count = 0
        for task in tasks {
            if(getDayOfTask(date: task.date!) == date) {
                if(task.isDone == false) {
                    count = count + 1
                }
            }
        }
        return count
    }

    
    var body: some View {
        ZStack {
            VStack{
                
                VStack(alignment : .leading) {
                    Text("Tasks organised by days")
                        .font(.custom("Poppins", size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("of the ongoing week : ")
                        .font(.custom("Poppins", size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 0.6379982829, green: 0.5591484904, blue: 0.843098104, alpha: 1)))
                    Image("Illustration4")
                        .resizable()
                        .scaledToFit()
                }

                
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(minimum: 100, maximum: 200)),
                        GridItem(.flexible(minimum: 100, maximum: 200)),
                        GridItem(.flexible(minimum: 100, maximum: 200))
                    ],
                    spacing: 16
                ) {
                    ForEach(weeks){ week in
                        ZStack {
                            RoundedRectangle(cornerRadius : 20)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                                .matchedGeometryEffect(id: "BG\(week.id)", in: animation)
                            
                            VStack{
                                HStack(alignment: .bottom, spacing: 12) {
                                    Text(week.day)
                                        .font(.custom("Poppins", size: 19))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.9))
                                        .matchedGeometryEffect(id: "jour\(week.id)", in: animation)
                                    
                                    Text(week.date)
                                        .font(.custom("Poppins", size: 19))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.9))
                                        .matchedGeometryEffect(id: "date\(week.id)", in: animation)
                                    
                                }

                                Text("Tasks left : " + String(getTaskCount(date: week.date)))
                                    .font(.custom("Poppins", size: 15))
                                    .foregroundColor(.white.opacity(0.9))

                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 30)
                            .onTapGesture {
                                withAnimation {
                                    currentDay = week
                                    isZoomed.toggle()
                                }
                            }
                        }.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 0.6379982829, green: 0.5591484904, blue: 0.843098104, alpha: 1)))

                    ZStack {
                        HStack {
                            Text("Don't feel overwhelmed and think about the free time you will get after")
                                .font(.custom("Poppins", size: 17))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
//                            Spacer()
                            Image("Illustration2")
                                .resizable()
                                .scaledToFit()
                        }
                        
                    }
                }
            }.opacity(isZoomed ? 0.4 : 1)
            
            if isZoomed {
                DayDetail(selectedDay: $currentDay, isZoomed: $isZoomed, animation: animation)
            }
        }
    }
}
