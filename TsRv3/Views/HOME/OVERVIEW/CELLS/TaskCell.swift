//
//  TaskCell.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct TaskCell: View {
    var task: Task
    @Namespace var animation
    @State var isZoomed = false
    
    var width: CGFloat {
        isZoomed ? UIScreen.main.bounds.size.width / 1.3 : UIScreen.main.bounds.size.width / 1.3
    }
    
    var height: CGFloat {
        isZoomed ? UIScreen.main.bounds.size.height / 5 : UIScreen.main.bounds.size.height / 6
    }
    
    func timePeriodTest(date: Date) -> DateComponents {
        
        let userDate = Calendar.current.dateComponents([.hour, .day, .month, .year], from: date)
        
        let userDateComponents = DateComponents(calendar: Calendar.current, year: userDate.year!, month: userDate.month!, day: userDate.day!, hour: userDate.hour!).date!
        
        let hoursUntil = Calendar.current.dateComponents([.hour], from: Date(), to: userDateComponents)
        
        return hoursUntil
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.clear)
                .shadow(color: Color(Color.RGBColorSpace.sRGB, white: 0.2, opacity: 0.4), radius: 4)
                .frame(width : width, height: height)
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
            
            if isZoomed == false {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(task.title! == "" ? "No Name" : task.title!)
                            .font(.custom("Poppins", size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .matchedGeometryEffect(id: "title", in: animation)
                        
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

                            }
                            
                            case 1 : ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color(#colorLiteral(red: 0.4637110704, green: 0.6992980542, blue: 0.2889392376, alpha: 1)))
                                Text("Medic")
                                    .font(.custom("Poppins", size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(5)

                            }
                            
                            case 2 : ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color(#colorLiteral(red: 1, green: 0.468347251, blue: 0.7559673283, alpha: 1)))
                                Text("School")
                                    .font(.custom("Poppins", size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(5)

                            }
                            
                            case 3 : ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color(#colorLiteral(red: 0.1193125199, green: 0.116432657, blue: 0.7812529064, alpha: 1)))
                                Text("Friend")
                                    .font(.custom("Poppins", size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(5)

                            }
                            
                            default : ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.white.opacity(0.4))
                                Text("No category")
                                    .font(.custom("Poppins", size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(5)

                            }
                            }
                        }.fixedSize()
                        
                    }.padding()
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    if (task.isDone == false) {
                        VStack {
                            Text("\(timePeriodTest(date: task.date!).hour!)h")
                                .font(.custom("Poppins", size: 25))
                                .fontWeight(.semibold)
                                .foregroundColor(timePeriodTest(date: task.date!).hour! < 24 ? .red : .white)
                                .padding(.trailing, 10)
                                .padding(.top, 18)
                            
                            Text("restantes")
                                .font(.custom("Poppins", size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }.padding(.trailing, 20)
                        .fixedSize()
                    }
                }
            }
            
            if isZoomed == true {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(task.title! == "" ? "No Name" : task.title!)
                            .font(.custom("Poppins", size: 25))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .matchedGeometryEffect(id: "title", in: animation)
                        
                        Text(task.descript!)
                            .font(.custom("Poppins", size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(#colorLiteral(red: 0.9481830001, green: 1, blue: 0.9818691611, alpha: 1)))
                    }.padding()
                    
                    Spacer()
                    
                }.frame(width: UIScreen.main.bounds.size.width / 1.3, height: UIScreen.main.bounds.size.height / 5)
            }
  
        }
        .frame(width : width, height: height)
        .gesture(TapGesture().onEnded {
            withAnimation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0)) {
                isZoomed.toggle()
            }
        })
    }
}


struct TaskCell_Previews: PreviewProvider {
    
    static var previews: some View {
        TaskCell(task: Task())
    }
}
