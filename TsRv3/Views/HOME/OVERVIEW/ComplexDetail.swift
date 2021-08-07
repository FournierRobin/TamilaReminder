//
//  ImportantDetail.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import SwiftUI

struct ComplexDetail: View {
    @Environment(\.presentationMode) var present
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "date", ascending: true)
        ]
    ) var tasks: FetchedResults<Task>
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Complex Tasks : ")
                .foregroundColor(Color.white)
                .font(.custom("Poppins", size: 25))
                .fontWeight(.semibold)
                .padding(.leading, 30)

            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 20){
                    ForEach(tasks){ task in
                        if (task.isDone == false && task.isComplex == true) {
                            TaskCell(task: task)
                        }
                    }
                }
            }
        }.padding(.top, 10)
    }
}


struct ComplexDetail_Previews: PreviewProvider {
    static var previews: some View {
        ComplexDetail()
    }
}

