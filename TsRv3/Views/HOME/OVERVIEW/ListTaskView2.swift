//
//  ListTaskView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct ListTaskView2: View {
    @State private var isShowingAddTask = false
    @State var taskConfig = NewTaskConfig()
    
    @State var importantSelected = false
    @State var complexSelected = false
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "date", ascending: true)
        ]
    ) var tasks: FetchedResults<Task>
    
    @FetchRequest(
        entity: Profile.entity(),
        sortDescriptors: []
    ) var profile: FetchedResults<Profile>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func getTaskDoneCount() -> Int {
        var count = 0
        for task in tasks {
                if(task.isDone == false) {
                    count = count + 1
                }
            }
        return count
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    if getTaskDoneCount() == 0 {
                        Spacer()
                        Text("You have no task planned at the moment, hit the + button to add one !")
                            .font(.custom("Poppins", size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        Spacer()
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment : .top, spacing : 10) {
                                ForEach(tasks) { task in
                                    if (task.isDone == false) {
                                        TaskCell(task: task)
                                            .padding(.horizontal, 10)
                                            .contextMenu{
                                                Button(action: {
                                                    taskConfig.gettingDone(task: task)
                                                    do {
                                                        try viewContext.save()
                                                    } catch {
                                                        print("Erreur lors de l'enregistrement")
                                                    }
                                                }, label: {
                                                    Text("Done")
                                                })
                                                
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
                    }
                    
                    Spacer()
                    
                    HStack(spacing : 30) {
                                ImpComCell(color: .blue, illustration: "Illustration2", category: "IMPORTANT")
                                    .onTapGesture {
                                        importantSelected.toggle()
                                    }

                                ImpComCell(color: Color(#colorLiteral(red: 1, green: 0, blue: 1, alpha: 1)), illustration: "Illustration5", category: "COMPLEX")
                                    .onTapGesture {
                                        complexSelected.toggle()
                                    }
                    }
                }.padding(.bottom, 30)
                .offset(x: importantSelected || complexSelected ? UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width * 2.3) : 0, y: 0)
                .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0))
                
                ZStack(alignment: .topLeading) {
                   ImportantDetail()
                        .offset(x: importantSelected ? 0 : 400, y: 0)
                        .animation(.spring(response: 0.6, dampingFraction: 1, blendDuration: 0))
                    GoBackChevron()
                        .offset(x: importantSelected ? -20 : 400, y : 0)
                        .animation(.spring(response: 0.7, dampingFraction: 1, blendDuration: 0))
                        .onTapGesture {
                            importantSelected.toggle()
                        }
                }.zIndex(2)
                
                ZStack(alignment: .topLeading) {
                   ComplexDetail()
                        .offset(x: complexSelected ? 0 : 400, y: 0)
                        .animation(.spring(response: 0.6, dampingFraction: 1, blendDuration: 0))
                    GoBackChevron()
                        .offset(x: complexSelected ? (-20) : 400, y : 0)
                        .animation(.spring(response: 0.7, dampingFraction: 1, blendDuration: 0))
                        .onTapGesture {
                            complexSelected.toggle()
                        }
                }.zIndex(2)
                 
            }
            
            
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
}

struct ListTaskView2_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            ListTaskView2()
        }
    }
}
