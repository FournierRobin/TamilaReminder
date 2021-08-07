//
//  ProductivityView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct ProductivityView: View {
    @State private var isShowingAddTask = false
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "date", ascending: true)
        ]
    ) var tasks: FetchedResults<Task>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        let countDone = tasks.filter {$0.isDone == true}.count
        
        VStack(spacing : 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.251537323, green: 0.5272958875, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.3763819337, green: 0.1696204245, blue: 0.7966271043, alpha: 1))]), startPoint: .topLeading, endPoint: .bottom))
                    .frame(width: UIScreen.main.bounds.size.width / 1.15, height: UIScreen.main.bounds.size.height / 6)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)
                
                VStack(alignment: .leading, spacing : 10) {
                    Text("Task Progress")
                        .foregroundColor(.white)
                        .font(.custom("Poppins", size: 20))
                        .fontWeight(.semibold)
                    
                    Text(String(countDone) + "/" + String(tasks.count) + " is completed")
                        .foregroundColor(.white)
                        .font(.custom("Poppins", size: 15))
                        .padding(.leading, 2)
                    
                    HStack {
                        ZStack(alignment : .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color.white.opacity(0.4))
                                .frame(width: UIScreen.main.bounds.size.width / 2 , height: 15)
                            
                            RoundedRectangle(cornerRadius: 5)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2075287998, green: 0.2111100852, blue: 0.2630086243, alpha: 1)), Color(#colorLiteral(red: 0.09261903912, green: 0.1018745527, blue: 0.1277030408, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: CGFloat(ratioBar()), height: 15)
                        }.padding(.trailing, 20)
                        
                        Text(String(pourcentage()) + "%")
                            .foregroundColor(.white)
                            .font(.custom("Poppins", size: 15))
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Text("Tasks Done : ")
                .foregroundColor(.white)
                .font(.custom("Poppins", size: 25))
                .fontWeight(.semibold)
            
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 20){
                    ForEach(tasks){ task in
                        if (task.isDone == true) {
                            TaskCell(task: task)
                                .contextMenu{
                                    Button(action: {
                                        viewContext.delete(task)
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                        }
                    }
                }
            }
            
            Spacer()
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
            })
            .padding(.bottom, 10)
            .sheet(isPresented: $isShowingAddTask, content: {
                AddTaskView()
            })
        }
    }
    
    func pourcentage() -> Int {
        
        let ratio = ratioBar() / Double(UIScreen.main.bounds.size.width / 2)
        var pourcentage = 0
        if (ratio != 0) {
            pourcentage = Int(ratio * 100.0)
        }
        return pourcentage
        
    }
    
    func ratioBar() -> Double {
        let countDone = tasks.filter {$0.isDone == true}.count
        let screen = Double(UIScreen.main.bounds.size.width / 2)
        let taskFakeCount = tasks.count == 0 ? 1 : tasks.count
        let ratioDoneUndone = Double(countDone) / Double(taskFakeCount)
        let ratioBar =  screen * Double(ratioDoneUndone)
        return Double(ratioBar)
    }
}

struct ProductivityView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            ProductivityView()
        }
    }
}
