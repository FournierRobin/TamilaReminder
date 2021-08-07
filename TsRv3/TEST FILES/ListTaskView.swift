//
//  ListTaskView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct ListTaskView: View {
    @State private var isShowingAddTask = false
    @State var taskConfig = NewTaskConfig()
    
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
    
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09195179492, green: 0.009325768799, blue: 0.277815938, alpha: 1)), Color(#colorLiteral(red: 0.02729733475, green: 0.003072797321, blue: 0.08043863624, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                        )
                    VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                    
                    VStack {
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
                        
                        Spacer()
                        
                        HStack(spacing : 30) {
                            NavigationLink(
                                destination: ImportantDetail(),
                                label: {
                                    ImpComCell(color: .blue, illustration: "Illustration2", category: "IMPORTANT")
                                }).navigationBarTitle("", displayMode: .inline)
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                            
                            NavigationLink(
                                destination: ComplexDetail(),
                                label: {
                                    ImpComCell(color: Color(#colorLiteral(red: 1, green: 0, blue: 1, alpha: 1)), illustration: "Illustration5", category: "COMPLEX")
                                }).navigationBarTitle("", displayMode: .inline)
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        }
                    }.padding(.bottom, 30)
                    
                    
                }
            }.navigationViewStyle(StackNavigationViewStyle())

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
            .padding(.bottom, 10)
            .sheet(isPresented: $isShowingAddTask, content: {
                AddTaskView()
            })
        }
    }
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            ListTaskView()
        }
    }
}


//            HStack{
//
//                Button(action: {
//                    //pop the view when back button pressed
//                    self.present.wrappedValue.dismiss()
//
//                }) {
//                    Image(systemName: "chevron.left")
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
//                }
//                Spacer()
//            }
