//
//  SaveCategoryView.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 10/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

//save product details view
struct SaveCategoryView : View {
    @State var name = ""
    @Binding var show : Bool
    @EnvironmentObject var observerCategory : ObserverCategory
    var category : Category
    
    var body: some View {
        ZStack () {
            VStack (spacing: 15) {
                //}
                HStack {
                    Image(systemName: "textbox")
                    TextField("Categoria: ", text: $name)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue))

                Button(action: {
                    //update or add product
                    if self.category.id != "" {
                        ObserverCategory().update(id: self.category.id, name: self.name)
                    } else {
                        ObserverCategory().add(name: self.name, date: Date())
                    }
                    self.show.toggle()
                }) {
                    Text("Salvar")
                }.padding()
            }.padding()
        }.onAppear {
            //edit tab
            self.name = self.category.name
        }
    }
}

