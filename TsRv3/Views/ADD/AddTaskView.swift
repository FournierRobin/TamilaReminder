//
//  AddTaskView.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct AddTaskView: View {
    @State var taskConfig = NewTaskConfig()
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        ZStack {
            Background()
            
            VStack(spacing : 20) {
                Text("Choose task's category :")
                    .font(.custom("Poppins", size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                //            Important, Complex Button
                HStack(spacing : 25) {
                    Button(action: {
                        taskConfig.isImportant.toggle()
                        hideKeyboard()
                    }, label: {
                        AddImpComCell(color: Color(#colorLiteral(red: 1, green: 0, blue: 1, alpha: 1)), illustration: "Illustration2", category: "IMPORTANT")
                            .overlay(
                                RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .stroke(taskConfig.isImportant ? Color.white : Color.clear, lineWidth: 4)
                            )
                    })
                    
                    Button(action: {
                        taskConfig.isComplex.toggle()
                        hideKeyboard()
                    }, label: {
                        AddImpComCell(color: Color(#colorLiteral(red: 0, green: 0.4881326556, blue: 0.9849180579, alpha: 1)), illustration: "Illustration5", category: "COMPLEX")
                            .overlay(
                                RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .stroke(taskConfig.isComplex ? Color.white : Color.clear, lineWidth: 4)
                            )
                    })
                }
                
                //                TextFields Name & Description
                CustomTF(text: $taskConfig.title, placeholder: "Task Name")
                CustomTF(text: $taskConfig.descript, placeholder: "Task Description")
                
                
                //            Date Picker
                DatePicker("Task Date", selection: $taskConfig.date)
                    .font(.custom("Poppins", size: 15))
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                    
                    .background(
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            //                            VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                        }.cornerRadius(30)
                    )
                    .padding(.horizontal, 20)
                
                //            Category Button
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment : .top, spacing : 15) {
                        
                        Button(action: {
                            taskConfig.category = 0
                            hideKeyboard()
                        }, label: {
                            CategCell(color: Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), illustration: "Illustration4", theme: "SPORT")
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(taskConfig.category == 0 ? Color.white : Color.clear, lineWidth: 4)
                                )
                        }).padding(.vertical, 20)
                        
                        Button(action: {
                            taskConfig.category = 1
                            hideKeyboard()
                        }, label: {
                            CategCell(color: Color(#colorLiteral(red: 0.4637110704, green: 0.6992980542, blue: 0.2889392376, alpha: 1)), illustration: "Illustration5", theme: "MEDIC")
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(taskConfig.category == 1 ? Color.white : Color.clear, lineWidth: 4)
                                )
                        }).padding(.vertical, 20)
                        
                        Button(action: {
                            taskConfig.category = 2
                            hideKeyboard()
                        }, label: {
                            CategCell(color: Color(#colorLiteral(red: 1, green: 0.468347251, blue: 0.7559673283, alpha: 1)), illustration: "Illustration2", theme: "SCHOOL")
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(taskConfig.category == 2 ? Color.white : Color.clear, lineWidth: 4)
                                )
                        }).padding(.vertical, 20)
                        
                        Button(action: {
                            taskConfig.category = 3
                            hideKeyboard()
                        }, label: {
                            CategCell(color: Color(#colorLiteral(red: 0.1193125199, green: 0.116432657, blue: 0.7812529064, alpha: 1)), illustration: "Illustration4", theme: "FRIEND")
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(taskConfig.category == 3 ? Color.white : Color.clear, lineWidth: 4)
                                )
                        }).padding(.vertical, 20)
                    }.padding(.horizontal, 10)
                }
                
                //            Add to Core Data Button
                Button(action: {
                    let newTask = Task(context: viewContext)
                    newTask.date = taskConfig.date
                    newTask.descript = taskConfig.descript
                    newTask.title = taskConfig.title
                    newTask.isDone = taskConfig.isDone
                    newTask.isImportant = taskConfig.isImportant
                    newTask.isComplex = taskConfig.isComplex
                    newTask.category = Int64(taskConfig.category)
                    newTask.id = UUID()
                    
                    do {
                        try viewContext.save()
                    } catch {
                        print("Erreur lors de l'enregistrement")
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                        Text("Save Task")
                            .font(.custom("Poppins", size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                })
            }.padding()
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}

extension AddTaskView {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
